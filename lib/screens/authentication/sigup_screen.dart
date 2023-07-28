import 'package:chatapp/component/app_button.dart';
import 'package:chatapp/component/appcolors.dart';
import 'package:chatapp/component/appimages.dart';
import 'package:chatapp/screens/authentication/login_screen.dart';
import 'package:chatapp/screens/authentication/phone_auth/sigin_phone.dart';
import 'package:chatapp/screens/authentication/stated_screen.dart';
import 'package:chatapp/utils/validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../component/app_textfield.dart';
import '../../controllers/auth_controller.dart';

class signup_Screen extends StatefulWidget {
  const signup_Screen({Key? key}) : super(key: key);

  @override
  State<signup_Screen> createState() => _signup_ScreenState();
}

class _signup_ScreenState extends State<signup_Screen> {


  final key = GlobalKey<FormState>();

  bool obscuretext = true;
  bool obscuretext1 = true;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Providers = Provider.of<siginGoogle>(context,listen: false);
    return Scaffold(
      body:
      Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Center(
                  child: Container(height: 100,
                    width: 100,
                    child: Image.asset(appImages.applogo),),
                ),
                SizedBox(height: 20,),
                Text("Welcome to Chat App ",style: GoogleFonts.alata(fontWeight: FontWeight.bold,color: appColors.blue,fontSize: 28),),
                SizedBox(height: 5,),
                Text("Enter Your Personal Information",style: GoogleFonts.alata(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 17),),
                SizedBox(height: 40,),


                appTextfield(title: "Username",onValidator: (value){return validateusername(value);}, myController: usernameController,iconimage: appImages.user),

                SizedBox(height: 20,),

                appTextfield(title: "Email",onValidator: (value){return validateEmail(value);}, myController: emailController,iconimage: appImages.email),

                SizedBox(height: 20,),

                appTextfield(title: "Password",onValidator:
                    (value){
                  return validatePassword(value);
                },obscuretext: obscuretext,Icon: InkWell(
                    onTap: () {
                      paswod();
                    },
                    child: Icon(obscuretext?Icons.visibility_off:Icons.visibility,color: Colors.grey,)),iconimage: appImages.lock, myController: passwordController,),

                SizedBox(height: 20,),

                appTextfield(title: "Confirm password",onValidator: (value){
                  if(value.isEmpty){
                     return "Confirm Password is required";
                  }else if(passwordController.text != confirmpasswordController.text){
                    return ("Password can't same");
                  }return null;
                },obscuretext: obscuretext1,iconimage: appImages.lock,

                  Icon: InkWell(
                    onTap: () {
                      paswod1();
                    },
                    child: Icon(obscuretext1?Icons.visibility_off:Icons.visibility,color: Colors.grey,)), myController: confirmpasswordController,),

                SizedBox(height: 30,),

                ChangeNotifierProvider(create: (_) => SignUp_Controller(),
                  child: Consumer<SignUp_Controller>(builder: (context, Provider, child) {
                    return appButton(title: "SignUp " ,onPressed: () {
                      if(key.currentState!.validate()){
                        Provider.signup(usernameController.text, emailController.text, passwordController.text,context);

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
                SizedBox(height: 15,),
                Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have a account?",style: appTextStyle.normalText(fontsize: 16),),SizedBox(width: 3,),
                    InkWell(onTap: () {
                      Get.off(loginScreen());
                    },
                        child: Text("Sign in",style: appTextStyle.normalText(fontsize: 16,fontweight: FontWeight.bold,colors: appColors.blue),)),
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
  paswod1() {
    setState(() {
      obscuretext1 = !obscuretext1;
    });
  }
}
