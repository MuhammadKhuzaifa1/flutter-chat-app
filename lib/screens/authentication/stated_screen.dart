import 'package:chatapp/component/appcolors.dart';
import 'package:chatapp/component/appimages.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:chatapp/controllers/auth_controller.dart';
import 'package:chatapp/screens/authentication/phone_auth/sigin_phone.dart';
import 'package:chatapp/screens/authentication/sigup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../component/app_button.dart';
import 'login_screen.dart';
import 'package:sign_in_button/sign_in_button.dart';
class statedScreen extends StatefulWidget {
  const statedScreen({Key? key}) : super(key: key);

  @override
  State<statedScreen> createState() => _statedScreenState();
}

class _statedScreenState extends State<statedScreen> {

  final Providers = siginGoogle();


  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value){
      FlutterNativeSplash.remove();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
           EdgeInsets.symmetric(horizontal: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
              child: Container(
                height: 300,
                width: 400,
                child: Image.asset(appImages.startscreen),
              ),
            ),
              SizedBox(height: 10),
              Text("Welcome to Chat App",style: GoogleFonts.alata(fontWeight: FontWeight.bold,fontSize: 27)),
              SizedBox(height: 5,),
              Text("Thank you very much for visiting our app Here you can easily send each other's"
                " messages Here you register your account and if you have not registered  so then "
                "login will be done You are safe here So create an account quickly.",
              style:  GoogleFonts.alata(fontWeight: FontWeight.w400)),
              SizedBox(height: 15,),
              appButton(title: "Register", Colors: appColors.blue, Colors1: Colors.white, onPressed: () {
                Get.off(signup_Screen());
              },),
              SizedBox(height: 15,),
              authbutton(Colors: Colors.green, Colors1: Colors.white, onPressed: () {

                Get.to(siginPhonenumber());

              },title: "Continue with Phone",image: appImages.phone,),
              SizedBox(height: 15,),
              authbutton(Colors: Colors.white, Colors1: Colors.black, onPressed: () {
                  Providers.signInGoogle();
                },title: "Continue with Google",image: appImages.google,),
              SizedBox(height: 15,),




          ],),
        ),
      ),
    );
  }
}
