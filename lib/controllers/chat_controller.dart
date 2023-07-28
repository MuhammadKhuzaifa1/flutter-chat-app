import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../utils/firebase_references.dart';

class usermessage extends ChangeNotifier{

  final auth = FirebaseAuth.instance;

 final time = DateTime.now();

  void SendMessage(String? message,friendId) async {
    FirebaseReference().message.add({
      'message': message,
      'senderId': auth.currentUser!.uid,
      'friendId': friendId,
      'date' :"${(time.hour > 12 ? time.hour - 12 : time.hour).abs()}:${time.minute} ${time.hour >= 12 ? "PM" : "AM"}",
    }).then((value) {
      value.update({'id' : value.id.toString()}).then((value) {
      });
    });
  }

}