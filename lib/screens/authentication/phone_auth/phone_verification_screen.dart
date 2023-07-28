import 'package:chatapp/component/appcolors.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:chatapp/screens/chatscreens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../component/app_button.dart';
import '../../../component/appimages.dart';
import '../../../component/comman_dialog.dart';
import '../../../utils/Sessions.dart';
import '../../../utils/firebase_references.dart';


class phoneVerificationscreen extends StatefulWidget {
  final String verificationId;
  const phoneVerificationscreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<phoneVerificationscreen> createState() => _phoneVerificationscreenState();
}

class _phoneVerificationscreenState extends State<phoneVerificationscreen> {
  final pinController = TextEditingController();
  final  key =  GlobalKey<FormState>();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      border: Border.all(color: appColors.blue),
      borderRadius: BorderRadius.circular(7),
    ),
  );

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 50,),
              Center(
                child: Container(height: 300,
                  width: 300,
                  child: Image.asset(appImages.phoneotp),),
              ),
              SizedBox(height: 20,),
                Text("Verification",style: GoogleFonts.alata(fontWeight: FontWeight.bold,color: appColors.blue,fontSize: 28),),
                Text("We sent OTP code to verify your number",style: GoogleFonts.alata(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 15),),
              SizedBox(height: 25,),
            Pinput(pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              validator: (value) {
                // CommanDialog.showErrorDialog(title: "Oops Error",description: "Pin is incorrect");


            },
              defaultPinTheme: defaultPinTheme,
              controller: pinController,
              length: 6,
              toolbarEnabled: false,
              // inputFormatters: [Formatter()],
            ),
                SizedBox(height: 25,),
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
                    InkWell(
                      onTap: () {
                        auth.verifyPasswordResetCode(widget.verificationId);
                      },
                        child: Text("Resend",style: appTextStyle.normalText(fontweight: FontWeight.bold,colors: appColors.blue),)),

                  ],
                ),
              SizedBox(height: 25,),
              appButton(title: "Verify",onPressed: ()async {
                if(key.currentState!.validate()){
                  final crendital = PhoneAuthProvider.credential(verificationId: widget.verificationId,
                      smsCode: pinController.text.toString());
                  try{
                    CommanDialog.showLoading();
                    await auth.signInWithCredential(crendital).then((value) {
                      SessionControler().userId = value.user!.uid.toString();
                      FirebaseReference().userDetail.doc(value.user!.uid).set({
                        "id" : value.user!.uid,
                        "email" : auth.currentUser!.email,
                        "onlineStatus" : "",
                        "username" : auth.currentUser!.displayName,
                        "profile": auth.currentUser!.photoURL,
                        "joindata": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",}).then((value){

                      });
                      Get.off(dashboardScreen());
                    });
                  }catch(e){
                    CommanDialog.hideLoading();

                  }
                }

              },),

            ],),
          ),
        ),
      ),
    );
  }
}
