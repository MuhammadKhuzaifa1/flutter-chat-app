import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'appcolors.dart';


class intlPhoneField extends StatefulWidget {
  final String? title;
  final Widget? Icon;
  final FormFieldValidator onValidator;
  final TextEditingController myController;
  final Function(dynamic) onChanged;
   intlPhoneField({Key? key,this.title, this.Icon,required this.onValidator, required this.myController,required this.onChanged}) : super(key: key);

  @override
  State<intlPhoneField> createState() => _intlPhoneFieldState();
}

class _intlPhoneFieldState extends State<intlPhoneField> {

  @override
  Widget build(BuildContext context) {
    return   IntlPhoneField(
       controller: widget.myController ,
        onChanged: widget.onChanged,
        // onChanged: (phone) {
        //  print("${widget.counterycode}ccccccccccccccccccccccccccccccccccccd");
        //    setState(() {
        //      widget.counterycode = phone.countryCode;
        //    });
        //   print(phone.completeNumber);},
        initialCountryCode: "PK",
        showCountryFlag: false,
        cursorColor: appColors.blue,
        validator: widget.onValidator,
        decoration: InputDecoration(
            label: Text(widget.title.toString()),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: appColors.blue,width: 1),),
            contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.teal),
            ),
            labelStyle:  GoogleFonts.rubik(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
            hintStyle: GoogleFonts.rubik(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w500)));
  }
}
