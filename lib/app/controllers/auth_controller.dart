import 'package:chat_app/app/data/models/users_model_model.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;

  var user = UsersModel().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> firstInitialize() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

  Future<bool> skipIntro() async {
    //  Ubah isAuth => true

    final box = GetStorage();
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      return true;
    }
    return false;
  }

  Future<bool> autoLogin() async {
    try {
      final isSign = await _googleSignIn.isSignedIn();
      if (isSign) {
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);
        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);
        print(userCredential);

        CollectionReference users = firestore.collection('users');

        // final checkuser = await users.doc(_currentUser!.email).get();
        // if (checkuser.data() == null) {
        //   users.doc(_currentUser!.email).set({
        //     "uid": userCredential!.user!.uid,
        //     "name": _currentUser!.displayName,
        //     "email": _currentUser!.email,
        //     "photo": _currentUser!.photoUrl ?? "noimage",
        //     "status": "",
        //     "creationTime":
        //         userCredential!.user!.metadata.creationTime!.toIso8601String(),
        //     "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
        //         .toIso8601String(),
        //     "updatedTime": DateTime.now().toIso8601String()
        //   });
        // } else {
        //   users.doc(_currentUser!.email).update({
        //     "lastSignTime": userCredential!.user!.metadata.lastSignInTime!
        //         .toIso8601String(),
        //     "updatedTime": DateTime.now().toIso8601String()
        //   });
        // }

        final currUser = await users.doc(_currentUser!.email).get();
        final currentUserData = currUser.data() as Map<String, dynamic>;

        user(UsersModel(
          uid: currentUserData['uid'],
          name: currentUserData['name'],
          email: currentUserData['email'],
          photoUrl: currentUserData['photo'],
          status: currentUserData['status'],
          creationTime: currentUserData['creationTime'],
          lastSignInTime: currentUserData['lastSignInTime'],
          updatedTime: currentUserData['updatedTime'],
        ));

        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> login() async {
    try {
      // Handle kebocoran data user sebelum login
      await _googleSignIn.signOut();
      // Dapatkan user google
      await _googleSignIn.signIn().then((value) => _currentUser = value);
      // Cek status login user
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        // Kondisi login berhasil
        print('Berhasil login dengan akun : ');
        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);
        print(userCredential);

        // Simpan bahwa pernah login
        final box = GetStorage();

        if (box.read('skipIntro') != null) {
          box.remove('skipIntro');
        }
        box.write('skipIntro', true);
        // Masukkan ke firestore
        CollectionReference users = firestore.collection('users');
        // Check user baru atau lama
        final checkuser = await users.doc(_currentUser!.email).get();
        if (checkuser.data() == null) {
          users.doc(_currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _currentUser!.displayName,
            "email": _currentUser!.email,
            "photo": _currentUser!.photoUrl ?? "noimage",
            "status": "",
            "creationTime":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedTime": DateTime.now().toIso8601String()
          });
        } else {
          users.doc(_currentUser!.email).update({
            "lastSignTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedTime": DateTime.now().toIso8601String()
          });
        }

        final currUser = await users.doc(_currentUser!.email).get();
        final currentUserData = currUser.data() as Map<String, dynamic>;

        user(UsersModel(
          uid: currentUserData['uid'],
          name: currentUserData['name'],
          email: currentUserData['email'],
          photoUrl: currentUserData['photo'],
          status: currentUserData['status'],
          creationTime: currentUserData['creationTime'],
          lastSignInTime: currentUserData['lastSignInTime'],
          updatedTime: currentUserData['updatedTime'],
        ));

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
      } else {
        print('Gagal');
      }

      print(_currentUser);
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await Get.offAllNamed(Routes.LOGIN);
  }

  void changeProfile(String name, String status) {
    String date = DateTime.now().toIso8601String();
    CollectionReference users = firestore.collection('users');

    users.doc(_currentUser!.email).update({
      "name": name,
      "status": status,
      "lastSignInTime":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedTime": date
    });

    user.update((user) {
      user!.name = name;
      user.status = status;
      user.lastSignInTime =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
    });

    user.refresh();
    Get.defaultDialog(title: 'Success', middleText: 'Change profile success');
    Get.back();
  }
}
