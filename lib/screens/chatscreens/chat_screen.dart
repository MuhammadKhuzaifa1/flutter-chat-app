import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/component/appimages.dart';
import 'package:chatapp/component/background_Color.dart';
import 'package:chatapp/component/user_message_style.dart';
import 'package:chatapp/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../component/appcolors.dart';
import '../../controllers/chat_controller.dart';
import '../../theme/theme_provider.dart';
import '../../utils/Sessions.dart';
import '../../utils/firebase_references.dart';
import 'call_screen.dart';

class chatScreen extends StatefulWidget {
  final String? senderId, userName, imageUrl, Email,onlinestatus;

  const chatScreen({
    Key? key,
    this.senderId,
    this.userName,
    this.imageUrl,
    this.Email, this.onlinestatus,
  }) : super(key: key);

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("online");
  }

  @override
  void setStatus(String status) async {
  await  FirebaseFirestore.instance.collection('UserDetail').doc(SessionControler().userId).update(
      {'onlineStatus' : status});}

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("online");
    } else {
      setStatus("offline");
    }
  }


  final messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    final Providers = Provider.of<usermessage>(context,listen: false);
    return Scaffold(
      backgroundColor: text == 'DarkTheme'?appColors.background:Color.fromRGBO(239, 230, 223, 1),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [

                  InkWell(onTap:(){

                      Get.to(callScreen(userId: '1',name: widget.userName.toString()));
    },
                      child: Icon(Icons.call,color: text == 'DarkTheme'?appColors.white:Colors.black,)),
                ],
              ),
            ),
          ],
          backgroundColor: text == 'DarkTheme'?appColors.background:Colors.white,
          automaticallyImplyLeading: false,
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(50)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl.toString(),
                  placeholder: (context, url) => Icon(
                    Icons.person,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.person),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(widget.userName.toString(),style: TextStyle(color: text == 'DarkTheme'?appColors.white:Colors.black,),),
            subtitle: Text(widget.onlinestatus.toString(),style: TextStyle(color: text == 'DarkTheme'?appColors.white:Colors.grey,),),
          ),

        ),
       body: StreamBuilder<QuerySnapshot>(
         stream: FirebaseReference().message.orderBy("date",descending: true).snapshots(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             return Column(
               children: [
                 Expanded(
                     child: ListView.builder(
                       physics: BouncingScrollPhysics(),
                       reverse: true,
                       controller: _scrollController,
                       itemCount: snapshot.data!.size,
                       itemBuilder: (context, index) {
                         if (SessionControler().userId == snapshot.data!.docs[index]['senderId'] ||
                             SessionControler().userId == snapshot.data!.docs[index]["friendId"]){
                           return Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: SingleChildScrollView(
                               child: Column(
                                 children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       snapshot.data!.docs[index]['friendId']== widget.senderId
                                           ? Flexible(
                                         child: Container(
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.only(
                                                   topLeft: Radius.circular(14),
                                                   topRight: Radius.circular(14),
                                                   bottomLeft: Radius.circular(14),
                                                 ),
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.black12,
                                                     blurRadius: 4,
                                                     offset: Offset(0,2)
                                                   )
                                                 ],
                                                 color: appColors.messagestyle1,),
                                             child: Padding(
                                               padding: const EdgeInsets.all(10),
                                               child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                 children: [
                                                   Text(
                                                     snapshot.data!.docs[index]
                                                     ['message'],
                                                     style: TextStyle(
                                                         fontSize: 18,
                                                         color: Colors.black87),
                                                   ),
                                                   Text(
                                                     snapshot.data!.docs[index]
                                                     ['date'].toString(),
                                                     style: TextStyle(
                                                         fontSize: 10,
                                                         color: Colors.black87),
                                                   )
                                                 ],
                                               ),
                                             )),
                                       )
                                           : Container(),
                                     ],
                                   ),  // Chat 1
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       snapshot.data!.docs[index]['senderId']== widget.senderId
                                           ? Flexible(
                                         child: Container(
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.only(
                                                   topLeft: Radius.circular(14),
                                                   topRight: Radius.circular(14),
                                                   bottomRight: Radius.circular(14),
                                                 ),
                                               boxShadow: [
                                                 BoxShadow(
                                                     color: Colors.black12,
                                                     blurRadius: 4,
                                                     offset: Offset(0,2)
                                                 )
                                               ],
                                                 color: text == 'DarkTheme'?Color.fromRGBO(30, 45, 50,1): Colors.white,
                                             ),
                                             child: Padding(
                                               padding: const EdgeInsets.all(10),
                                               child:Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                 children: [
                                                   Text(
                                                     snapshot.data!.docs[index]
                                                     ['message'],
                                                     style: TextStyle(
                                                         fontSize: 18,
                                                         color:text == 'DarkTheme'?Colors.white: Colors.black),
                                                   ),
                                                   Text(
                                                     snapshot.data!.docs[index]
                                                     ['date'].toString(),
                                                     style: TextStyle(
                                                         fontSize: 10,
                                                         color:text == 'DarkTheme'?Colors.white: Colors.black),
                                                   )
                                                 ],
                                               ),
                                             )),
                                       )
                                           : Center(
                                         child: Container(),
                                       )
                                     ],
                                   ),  // Chat 2
                                 ],
                               ),
                             ),
                           );

                         }else{
                           return Container(


                           );
                         }


                       },
                     )),
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: Row(
                     children: [
                       Expanded(
                           child: Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: text == 'DarkTheme'?Color.fromRGBO(30, 45, 50,1):Colors.white,
                                 boxShadow: [
                                   BoxShadow(
                                     offset: (Offset(1, 2)),
                                     color: Colors.black12,
                                     blurRadius: 2,
                                   )
                                 ]),
                             child: Flexible(
                               child: TextField(
                                   controller: messageController,
                                   maxLines: null,
                                   decoration: InputDecoration(
                                       prefixIcon: Icon(
                                         Icons.emoji_emotions_outlined,
                                         color: Colors.grey,
                                         size: 30,
                                       ),
                                       border: InputBorder.none,
                                       hintStyle: TextStyle(color: Colors.blue),
                                       hintText: 'Type Something...')),
                             ),
                           )),
                       SizedBox(
                         width: 5,
                       ),
                       CircleAvatar(
                         radius: 24,
                         backgroundColor: Color.fromRGBO(0, 170, 132, 1),
                         child: CupertinoButton(
                           padding: EdgeInsets.zero,
                           onPressed: () {
                             // _scrollToBottom();
                             Providers.SendMessage(messageController.text.toString(),widget.senderId);

                             messageController.clear();
                           },
                           child: Icon(
                             Icons.send,
                             color: Colors.white,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             );
           } else {
             return Center(
               child: CircularProgressIndicator(),
             );
           }
         },
       ),
    );
  }


}
