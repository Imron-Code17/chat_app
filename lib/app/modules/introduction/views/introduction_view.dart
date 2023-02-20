import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Berinteraksi dengan mudah",
          body: "Kamu hanya perlu dirumah saja untuk mendapatkan teman baru.",
          image: Container(
            height: Get.width * 0.6,
            width: Get.width * 0.6,
            child: Lottie.asset('assets/lottie/main-laptop-duduk.json'),
          ),
        ),
        PageViewModel(
          title: "Temukan semangat baru",
          body: "Jika kamu jodoh melalui aplikasi ini, selamat kamu bahagia. ",
          image: Container(
            height: Get.width * 0.6,
            width: Get.width * 0.6,
            child: Lottie.asset('assets/lottie/ojek.json'),
          ),
        ),
        PageViewModel(
          title: "Aplikasi bebas biaya",
          body: "Jangan khawatir, aplikasi ini gratis .",
          image: Container(
            height: Get.width * 0.6,
            width: Get.width * 0.6,
            child: Lottie.asset('assets/lottie/payment.json'),
          ),
        ),
        PageViewModel(
          title: "Gabung Sekarang Juga",
          body: "Daftarkan dirikamu untuk menjadi bagian kami.",
          image: Container(
            height: Get.width * 0.6,
            width: Get.width * 0.6,
            child: Lottie.asset('assets/lottie/register.json'),
          ),
        ),
      ],
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Text("Next"),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w700)),
      onDone: () {
        Get.offAllNamed(Routes.LOGIN);
      },
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Theme.of(context).colorScheme.secondary,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    ));
  }
}
