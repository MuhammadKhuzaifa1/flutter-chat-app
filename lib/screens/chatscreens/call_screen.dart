import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class callScreen extends StatefulWidget {
 final String userId,name;
  const callScreen({Key? key, required this.userId, required this.name,}) : super(key: key);

  @override
  State<callScreen> createState() => _callScreenState();
}

class _callScreenState extends State<callScreen> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: 453580186,
        appSign: "3f0407ccfecc5e5793e001c4c18f43ff991085b9d5f4a8a081806c83a710dfb2",
        callID: "Brother Code",
        userID: widget.userId,
        userName: widget.name,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
  }
}
