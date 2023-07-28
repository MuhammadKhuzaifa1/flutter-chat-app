import 'dart:async';
import 'package:chatapp/component/app_button.dart';
import 'package:chatapp/component/appcolors.dart';
import 'package:chatapp/component/appimages.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:chatapp/component/comman_dialog.dart';
import 'package:chatapp/screens/authentication/login_screen.dart';
import 'package:chatapp/screens/authentication/sigup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../chatscreens/dashboard_screen.dart';


class verificationScreen extends StatefulWidget {
  const verificationScreen({super.key});
  @override
  State<verificationScreen> createState() => _verificationScreenState();
}

class _verificationScreenState extends State<verificationScreen> {


  int timelift = 30;

  void statcout(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(timelift > 0){
        setState(() {
          timelift--;
        });
      }else{
        timer.cancel();
      }
    });
  }


  Timer? timer;
  bool isVerified = false;
  @override
  void initState() {
    super.initState();
     statcout();
    FlutterNativeSplash.remove();
    _auth.currentUser!.sendEmailVerification();
    isVerified = _auth.currentUser!.emailVerified;
    timer = Timer.periodic(Duration(seconds: 4), (_) => EmailVerificatoin());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future EmailVerificatoin() async {
    await _auth.currentUser!.reload();
    setState(() {
      isVerified = _auth.currentUser!.emailVerified;
    });
    if (isVerified) {
      timer?.cancel();
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return
      isVerified
        ? dashboardScreen()
        :
    Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(appImages.otp),
            Text(
              "Verified Your Email",
              style: appTextStyle.normalText(fontweight: FontWeight.bold,colors: appColors.blue,fontsize: 28)
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "A verification email has been send to  ${_auth.currentUser!.email.toString()}",
               style: appTextStyle.normalText(colors: Colors.grey,fontsize: 16),      textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Please check your email and follow this link to activate your account.",
              textAlign: TextAlign.center,
              style: appTextStyle.normalText(colors: appColors.blue),),

            SizedBox(
              height: 20,
            ),
           appButton(title: "Back",onPressed: () {
             // Get.off(loginScreen());
             statcout();
           },),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont't receive link Verification",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 13)),
                SizedBox(
                  width: 5,
                ),

                ChangeNotifierProvider(create: (_) => Verification_Controller(),
                  child: Consumer<Verification_Controller>(builder: (context, Provider, child) {
                    return InkWell(onTap: () {
                      setState(() {
                        statcout();
                      });
                        Provider.Verification(context);

                        // Utils.flushBarMessage("Email has been send check your email", context);
                    },
                        child:Provider.loading? Container(height: 15,width: 15,
                            child: Center(child: CircularProgressIndicator())):

                       timelift != 0?
                    Text("00:${timelift.toString()}",
                      style: appTextStyle.normalText(fontweight:
                      FontWeight.bold,colors: appColors.blue),): Text("Resend",style: appTextStyle.normalText(colors: appColors.blue,fontweight: FontWeight.bold),));

                  },),),

              ],
            )
          ],
        ),
      ),
    );
  }
}
