import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/component/appcolors.dart';
import 'package:chatapp/component/appimages.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:chatapp/utils/Sessions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../theme/change_theme_button_widget.dart';
import '../../theme/theme_provider.dart';
import '../../utils/firebase_references.dart';
import '../authentication/login_screen.dart';
import 'call_screen/login_service.dart';
import 'chat_screen.dart';
import 'dart:developer';
class dashboardScreen extends StatefulWidget {
  const dashboardScreen({Key? key}) : super(key: key);

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String name = "";
  final searchController = TextEditingController();


  final user = FirebaseAuth.instance.currentUser!;


  final String collectionName = 'UserDetail';
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      FlutterNativeSplash.remove();
    });
    super.initState();
    _initAsyncOperations();
  }

  Future<void> _initAsyncOperations() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String targetDocumentId = currentUser.uid;
      DocumentSnapshot? document = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(targetDocumentId)
          .get();
      if (document.exists) {
        String documentId = document.id;
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        print("abcbc${data["username"].toString()}");
        print("aababa ${documentId}");

        // Call onUserLogin
        onUserLogin(
          userID: documentId,
          userName: data["username"].toString(),
        );


      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: CircleAvatar(
            radius: 27,
            backgroundColor: Color.fromRGBO(0, 170, 132, 1),
            child: Icon(
              Icons.message,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          log("message");
        },
      ),
      backgroundColor:
          text == 'DarkTheme' ? appColors.background : Colors.white,
      // backgroundColor: text == 'DarkTheme'?Colors.black:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          InkWell(onTap: ()async {
            auth.signOut();
            await GoogleSignIn;
            GoogleSignIn().signOut();
            Get.off(loginScreen());
          log("logout");

          },
              child: Icon(Icons.logout)),
        ],
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        title: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(appImages.black),fit: BoxFit.cover),),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title:
            auth.currentUser!.displayName == null? Text("Username",style: appTextStyle.normalText(colors: Colors.white),):
            Text(auth.currentUser!.displayName.toString(),
              style: appTextStyle.normalText(colors: Colors.white),),subtitle: Text(auth.currentUser!.email.toString(),style: appTextStyle.normalText(colors: Colors.white),),
            leading:   CircleAvatar(backgroundImage: NetworkImage(auth.currentUser!.photoURL.toString()),),
          ),
        )
      
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.all(10),
                //     child: Container(
                //       height: 50,
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(35),
                //           border: Border.all(color: Colors.black12, width: 1)
                //
                //       ),
                //       child: TextFormField(
                //               autofocus: false,
                //         controller: searchController,
                //         decoration: InputDecoration(hintText: "Search... ",
                //             prefixIcon: Icon(Icons.search),
                //
                //             // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                //             border: InputBorder.none),
                //         onChanged: (value) {
                //           setState(() {
                //             name = value;
                //           });
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                Text("Chat App",
                    style: appTextStyle.normalText(
                      fontweight: FontWeight.w500,
                      fontsize: 25,
                      colors: text == 'DarkTheme' ? Colors.white : Colors.black,
                    )),
                Row(
                  children: [
                    ChangeThemeButtonWidget(),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.search,
                      color: text == 'DarkTheme' ? Colors.white : Colors.black,
                    ),
                    PopupMenuButton(
                      itemBuilder: (ctx) => [
                        _buildPopupMenuItem(Text("Profile"), () {}),
                        _buildPopupMenuItem(Text("Logout"), () async {
                          SessionControler().userId = "";
                          await GoogleSignIn().signOut();
                          Get.off(loginScreen());
                        }),
                        _buildPopupMenuItem(ChangeThemeButtonWidget(), () {}),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseReference().userDetail.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      if (SessionControler().userId ==
                          snapshot.data!.docs[index]['id']) {
                        return Container();
                      } else {
                        if (name.isEmpty) {
                          return Container(
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Get.to(chatScreen(
                                      userName: data['username'].toString(),
                                      Email: data['email'].toString(),
                                      imageUrl: data['profile'].toString(),
                                      senderId: data['id'].toString(),
                                      onlinestatus:
                                          data['onlineStatus'].toString(),
                                    ));
                                  },
                                  title: Text(data['username'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: text == 'DarkTheme'
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                  subtitle: Text(
                                    "Hello How are you",
                                    style: appTextStyle.normalText(
                                        colors: Colors.grey),
                                  ),
                                  leading: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                        color: appColors.userdp,
                                        // border: Border.all(
                                        //     color:  text == 'DarkTheme'?Colors.white70:Colors.black26,),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: CachedNetworkImage(
                                        imageUrl: data['profile'],
                                        placeholder: (context, url) => Icon(
                                          Icons.person,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Padding(
                                          padding: const EdgeInsets.only(
                                              top: 13, left: 3, right: 3),
                                          child: Image.asset(appImages.profile,
                                              fit: BoxFit.cover,
                                              color: appColors.person),
                                        ),
                                        // Icon(Icons.person,color: text == 'DarkTheme'?Colors.white70:Colors.black38,size:40,),
                                      ),
                                    ),
                                  ),
                                  trailing: Text(
                                    "12:09 PM",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                              ],
                            ),
                          );
                        }
                        if (data['username']
                            .toString()
                            .toLowerCase()
                            .startsWith(name.toLowerCase())) {
                          return ListTile(
                            onTap: () {
                              Get.to(chatScreen(
                                userName: data['username'].toString(),
                                Email: data['email'].toString(),
                                imageUrl: data['profile'].toString(),
                                senderId: data['id'].toString(),
                              ));
                            },
                            title: Text(data['username'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text(
                              data['email'],
                              style: appTextStyle.normalText(),
                            ),
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     color: Colors.black12),
                                  borderRadius: BorderRadius.circular(50)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CachedNetworkImage(
                                  imageUrl: data['profile'],
                                  placeholder: (context, url) => Icon(
                                    Icons.person,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.person),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      }
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(Widget widgets, VoidCallback onpressed) {
    return PopupMenuItem(
      child: InkWell(onTap: onpressed, child: widgets),
    );
  }
}
// Column(mainAxisAlignment: MainAxisAlignment.center,
// children: [
//
// Text(SessionControler().userId.toString()),
// Padding(
// padding: const EdgeInsets.all(25),
// child: Center(child:
// appButton(title: "Logout", Colors: Colors.white, Colors1: Colors.black, onPressed: ()async {
// auth.signOut();
// await GoogleSignIn;
// GoogleSignIn().signOut();
// await auth.signOut();
// Get.off(loginScreen());
// },),),
// ),
//
//
//
// ],
// ),
