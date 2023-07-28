
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseReference{

  CollectionReference userDetail = FirebaseFirestore.instance.collection('UserDetail');
  CollectionReference post = FirebaseFirestore.instance.collection('posts');
  CollectionReference message = FirebaseFirestore.instance.collection('messages');

}