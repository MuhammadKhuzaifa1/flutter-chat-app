import 'package:chatapp/component/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appTextfield extends StatefulWidget {
 final String? title,iconimage;
 final Widget? Icon;
 final bool? obscuretext;
 final FormFieldValidator onValidator;
 final TextEditingController myController;
  const appTextfield({Key? key, this.title, this.Icon, this.obscuretext = false, required this.onValidator, required this.myController, this.iconimage,}) : super(key: key);

  @override
  State<appTextfield> createState() => _appTextfieldState();
}

class _appTextfieldState extends State<appTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: appColors.blue,
    controller: widget.myController,
    validator: widget.onValidator,
    obscureText: widget.obscuretext!,
    decoration: InputDecoration(

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: appColors.blue,width: 1),),
      suffixIcon:  widget.Icon,
      prefixIcon: Container(height: 3,width: 3,child: Padding(
      padding: const EdgeInsets.all(14),
      child: Image.asset(widget.iconimage.toString(),color: Colors.grey),
    ),),
      contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.teal),
      ),

      // hintText: widget.title,
      label: Text(widget.title.toString()),
      labelStyle:  GoogleFonts.rubik(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
      hintStyle: GoogleFonts.rubik(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w500)
    ),
    );
  }
}
