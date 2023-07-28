import 'package:flutter/material.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:provider/provider.dart';
import '../../component/app_button.dart';
import '../../component/app_textfield.dart';
import '../../component/appimages.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/validate.dart';

class forgotScreen extends StatefulWidget {
  const forgotScreen({Key? key}) : super(key: key);

  @override
  State<forgotScreen> createState() => _forgotScreenState();
}

class _forgotScreenState extends State<forgotScreen> {

  final emailController = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: Form(
           key: key,
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(height: 10,),
                 Center(
                   child: Container(height: 350,
                     width: 350,
                     child: Image.asset(appImages.forgot),),
                 ),
                 SizedBox(height: 10,),
                 Text("Forgot Password?",style: appTextStyle.normalText(fontweight: FontWeight.bold,fontsize: 28),),
                 SizedBox(height: 5,),
                 Text("Don't worry! occurs Please enter the email address linked with your account.",
                   style: appTextStyle.normalText(fontweight: FontWeight.w500,),),
                 SizedBox(height: 30,),
                 Text("Email",style: appTextStyle.normalText(fontweight: FontWeight.w500,fontsize: 16),),
                 SizedBox(height: 5,),
                 appTextfield(title: "Enter you email",iconimage: appImages.email,
                   onValidator: (value){
                   return validateEmail(value);
                 }, myController: emailController,),
                 SizedBox(height: 20,),
                 ChangeNotifierProvider(create: (_) => forgot_Controller(),
                   child: Consumer<forgot_Controller>(builder: (context, Provider, child) {
                     return appButton(title: "Recover " ,onPressed: () {
                       if(key.currentState!.validate()){
                         Provider.forgot(emailController.text, context);


                       }
                     },);

                   },),),


               ],
             ),
           ),
         ),
       ),
    );
  }
}
