class ChatsModel {
  List<String>? connections;
  List<Chat>? chat;

  ChatsModel({this.connections, this.chat});

  ChatsModel.fromJson(Map<String, dynamic> json) {
    connections = json['connections'].cast<String>();
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(new Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connections'] = this.connections;
    if (this.chat != null) {
      data['chat'] = this.chat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chat {
  String? pengirim;
  String? penerima;
  String? pesan;
  String? time;
  bool? isRead;

  Chat({this.pengirim, this.penerima, this.pesan, this.time, this.isRead});

  Chat.fromJson(Map<String, dynamic> json) {
    pengirim = json['pengirim'];
    penerima = json['penerima'];
    pesan = json['pesan'];
    time = json['time'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pengirim'] = this.pengirim;
    data['penerima'] = this.penerima;
    data['pesan'] = this.pesan;
    data['time'] = this.time;
    data['isRead'] = this.isRead;
    return data;
  }
}
