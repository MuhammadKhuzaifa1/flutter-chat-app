import 'package:flutter/material.dart';

class Background_Image extends StatefulWidget {
  final Widget? child;
  final String? images;
  const Background_Image({Key? key, this.child, this.images}) : super(key: key);

  @override
  State<Background_Image> createState() => _Background_ImageState();
}

class _Background_ImageState extends State<Background_Image> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
          image: DecorationImage(image:
          AssetImage(widget.images.toString()),fit: BoxFit.cover)),child: widget.child,
    );
  }
}

