import 'package:chatapp/component/appcolors.dart';
import 'package:chatapp/component/appimages.dart';
import 'package:chatapp/component/apptextstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class CommanDialog {
  static showLoading({String title = "Loading..."}) {
    Get.dialog(
      Dialog(backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
       child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SpinKitFadingCircle(color: Colors.white,),
           // CircularProgressIndicator(color: Colors.white,strokeWidth: 4,),
           SizedBox(height: 6,),
           Text("Loading...",style: appTextStyle.normalText(colors: Colors.white,fontweight: FontWeight.bold),),
         ],
       )),
      ),
      barrierDismissible: false,
    );
  }

  static hideLoading() {
    Get.back();
  }

  static showErrorDialog(
      {String title = "Oops Error",
        String description = "Something went wrong "}) {
    Get.dialog(
      Dialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: appTextStyle.normalText(colors: Colors.black,fontweight: FontWeight.bold,fontsize: 20),
                  ),SizedBox(width: 5,),
                  Icon(Icons.error_outline,color: Colors.red,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  description,
                  style: appTextStyle.normalText(colors: Colors.black,fontweight: FontWeight.w400,fontsize: 15),
                ),
              ),SizedBox(height: 20,),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(height: 35,width: 55,
                    decoration:  BoxDecoration(borderRadius: BorderRadius.circular(7),color: appColors.blue),
                    child: Center(child: Text("Retry",style: appTextStyle.normalText(colors: Colors.white),),),),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }


}
