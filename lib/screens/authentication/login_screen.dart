import 'package:chatapp/component/app_button.dart';
import 'package:chatapp/component/appimages.dart';
import 'package:chatapp/screens/authentication/phone_auth/sigin_phone.dart';
import 'package:chatapp/screens/authentication/sigup_screen.dart';
import 'package:chatapp/screens/authentication/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:chatapp/component/appcolors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../component/app_textfield.dart';
import '../../component/comman_dialog.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/validate.dart';
import 'forgotscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  bool obscuretext = true;
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final Providers = Provider.of<siginGoogle>(context,listen: false);
    return Scaffold(
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
                children: [

                SizedBox(height: 25,),
                Center(
                child: Container(height: 150,
                width: 150,
                child: Image.asset(appImages.applogo),),
              ),
                SizedBox(height: 20,),
                Text("Welcome Back",style: GoogleFonts.alata(fontWeight: FontWeight.bold,color: appColors.blue,fontSize: 28),),
                SizedBox(height: 5,),

                Text("Login to continue using the app",style: GoogleFonts.alata(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 17),),
                SizedBox(height: 30,),

                SizedBox(height: 5,),
                appTextfield(title: "Email",onValidator: (value) { return validateEmail(value);}, myController: emailController,iconimage: appImages.email),
                SizedBox(height: 15,),

                SizedBox(height: 5,),
                appTextfield(myController: passwordController, title: "Password",onValidator: (value) {return validatePassword(value);},obscuretext: obscuretext,Icon: InkWell(
                  onTap: () {
                    if(key.currentState!.validate()){

                    }
                    paswod();
                  },

                    child:
                    Icon(obscuretext?Icons.visibility_off:Icons.visibility,color: Colors.grey,)),iconimage: appImages.lock),
                SizedBox(height: 8,),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(onTap: () {
                      Get.to(forgotScreen());
                      emailController.clear();
                      passwordController.clear();
                    },
                        child: Text("Forgot password ",style: GoogleFonts.alata(fontWeight: FontWeight.w500,color: appColors.blue,fontSize: 15),)),
                  ],
                ),
                SizedBox(height: 20,),

                  ChangeNotifierProvider(create: (_) => login_Controller(),
                    child: Consumer<login_Controller>(builder: (context, Provider, child) {
                      return appButton(title: "Login " ,onPressed: () {

                        if(key.currentState!.validate()){
                          Provider.Login(emailController.text, passwordController.text, context);

                        }
                      },);

                    },),),
                  SizedBox(height: 18,),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Text(" or Sign in using ",style: appTextStyle.normalText(),),
                      Expanded(child: Divider()),


                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Providers.signInGoogle();
                        },
                        child: Container(height: 40,width: 40,decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(appImages.google),),
                      ),
                      SizedBox(width: 15,),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.to(siginPhonenumber());
                        },
                        child: Container(height: 45,width: 45,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Image.asset(appImages.phone),
                          ),),
                      ),
                    ],
                  ),
                  Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: GoogleFonts.alata(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 15),),SizedBox(width: 3,),
                    InkWell(onTap: () {
                      Get.to(signup_Screen());
                    },
                        child: Text("Register",style: GoogleFonts.alata(fontWeight: FontWeight.bold,color: appColors.blue,fontSize: 15),)),
                  ],
                )),

                  SizedBox(height: 20,),




            ],),
          ),
        ),
      ),
    );
  }
  paswod() {
    setState(() {
      obscuretext = !obscuretext;
    });
  }

}
