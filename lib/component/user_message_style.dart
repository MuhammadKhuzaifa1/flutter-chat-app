import 'package:flutter/material.dart';



class userMessagsestyle extends StatefulWidget {
final  String?senderId,friendId,messages,senderId2;
  const userMessagsestyle({Key? key, this.senderId, this.friendId, this.messages, this.senderId2}) : super(key: key);

  @override
  State<userMessagsestyle> createState() => _userMessagsestyleState();
}

class _userMessagsestyleState extends State<userMessagsestyle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.friendId == widget.senderId2
                      ? Flexible(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                            color: Color.fromARGB(
                                255, 221, 245, 255),
                            border: Border.all(
                                color: Colors.lightBlue)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.messages.toString(), style: TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                        )),
                  )
                      : Container(),
                ],
              ),  // Chat 1
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.senderId == widget.senderId2
                      ? Flexible(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                            color: Color.fromARGB(
                                255, 218, 255, 176),
                            border: Border.all(
                                color: Colors.lightGreen)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.messages.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87),
                          ),
                        )),
                  )
                      : Center(
                    child: Container(),
                  )
                ],
              ),  // Chat 2
            ],
          ),
        ),
      ),
    );
  }
}
