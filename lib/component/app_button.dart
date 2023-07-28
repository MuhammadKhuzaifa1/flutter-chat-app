import 'package:chatapp/component/appcolors.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appimages.dart';


class appButton extends StatefulWidget {
  final Color? Colors,Colors1;
 final String? title;
 final VoidCallback? onPressed;
  const appButton({Key? key, this.title, this.onPressed, this.Colors =  appColors.blue, this.Colors1 = appColors.white}) : super(key: key);

  @override
  State<appButton> createState() => _appButtonState();
}

class _appButtonState extends State<appButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.3),),
            color: widget.Colors,
          boxShadow: [
            BoxShadow(
              offset: Offset(1,2),blurRadius: 5,color: Colors.black.withOpacity(0.1),

            )
          ]
        ),
        child: Center(
          child: Text(widget.title.toString(),style: GoogleFonts.alata(fontWeight: FontWeight.w500,color: widget.Colors1,fontSize: 15),),
        ),
      ),
    );
  }
}





class authbutton extends StatefulWidget {
  final Color? Colors,Colors1;
  final String? title,image,authTitle;
  final VoidCallback? onPressed;
  const authbutton({Key? key, this.Colors, this.Colors1, this.title, this.onPressed, this.image, this.authTitle}) : super(key: key);

  @override
  State<authbutton> createState() => _authbuttonState();
}

class _authbuttonState extends State<authbutton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.withOpacity(0.3),),
            color: widget.Colors,
            boxShadow: [
              BoxShadow(
                offset: Offset(1,2),blurRadius: 5,color: Colors.black.withOpacity(0.1),

              )
            ]
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 25,width: 25,child: Image.asset(widget.image.toString()),),
            SizedBox(width: 9,),
            Text(widget.title.toString(),style: GoogleFonts.alata(fontWeight: FontWeight.w500,color: widget.Colors1,fontSize: 15),),
          ],
        ),
      ),
    );
  }
}
