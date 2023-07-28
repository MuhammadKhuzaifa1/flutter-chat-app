import 'package:chatapp/component/app_button.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:chatapp/component/comman_dialog.dart';
import 'package:chatapp/screens/authentication/phone_auth/phone_verification_screen.dart';
import 'package:chatapp/screens/chatscreens/dashboard_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../component/app_textfield.dart';
import '../../../component/appcolors.dart';
import '../../../component/appimages.dart';
import '../../../component/intl_phone_field.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/validate.dart';


class siginPhonenumber extends StatefulWidget {
  const siginPhonenumber({Key? key}) : super(key: key);

  @override
  State<siginPhonenumber> createState() => _siginPhonenumberState();
}

class _siginPhonenumberState extends State<siginPhonenumber> {


  String countercodes = '';
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();



  final auth = FirebaseAuth.instance;
  final Providers = siginPhonenumber();
  final   key = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [


              SizedBox(height: 40,),
              Center(
                child: Container(height: 170,
                  width: 170,
                  child: Image.asset(appImages.applogo,),
              ),),
              SizedBox(height: 50,),
              Text("Welcome to Chat App ",style: GoogleFonts.alata(fontWeight: FontWeight.bold,color: appColors.blue,fontSize: 28),),
              SizedBox(height: 5,),

              Text("Enter Your mobile number and login",style: GoogleFonts.alata(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 15),),
              SizedBox(height: 30,),

              appTextfield(title: "Username",onValidator: (value){return validateusername(value);}, myController: usernameController,iconimage: appImages.user),

              SizedBox(height: 20,),

              intlPhoneField(onValidator: (value) {}, myController: phoneController,
                title: "Phone", onChanged: (phone) {
                setState(() {
                  countercodes = phone.countryCode;});
                print("${phone.completeNumber}code --------------------------------------");
                },),

              SizedBox(height: 30,),

              ChangeNotifierProvider(create: (_) => siginphoneNumber(),
                child: Consumer<siginphoneNumber>(builder: (context, Provider, child) {
                  return appButton(title: "Next " ,onPressed: () {

                    if(key.currentState!.validate()) {
                      Provider.siginPhone("+${countercodes}${phoneController.text.trim()}");

                    }

                  },);

                },),),


            ],),
          ),
        ),
      ),
    );
  }
}
