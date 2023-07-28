import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatapp/screens/authentication/login_screen.dart';
import 'package:chatapp/screens/authentication/verification_screen.dart';
import 'package:chatapp/screens/chatscreens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/comman_dialog.dart';
import '../screens/authentication/phone_auth/phone_verification_screen.dart';
import '../utils/Sessions.dart';
import '../utils/Utils.dart';
import '../utils/firebase_references.dart';

class login_Controller extends ChangeNotifier {
  bool _loading = false;

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void Login(String email, String password, BuildContext context) async {
    CommanDialog.showLoading();
    try {
      final user = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionControler().userId = value.user!.uid.toString();
        CommanDialog.hideLoading();
        if (auth.currentUser!.emailVerified == true) {
          CommanDialog.hideLoading(); // changed dead code
          return Get.off(dashboardScreen());
        } else {
          auth.currentUser!.sendEmailVerification();
          CommanDialog.hideLoading();
          return Get.off(verificationScreen());
        }
      });
    } on FirebaseAuthException catch (e) {
      CommanDialog.hideLoading();
      if (e.code == 'user-not-found') {
        CommanDialog.showErrorDialog(
            title: "User not found",
            description: "No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CommanDialog.hideLoading();
        CommanDialog.showErrorDialog(
            title: "Incorrect Password",
            description: "Wrong password Please try again.");
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print("11111111111111111111111111");
      print(e);
    }
  }
}

class SignUp_Controller extends ChangeNotifier {
  bool _loading = false;
  List data = [];
  String Id = "";

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  // DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");

  void signup(String username, String email, String password,
      BuildContext context) async {
    CommanDialog.showLoading();
    try {
      final user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionControler().userId = value.user!.uid.toString();
        auth.currentUser!.sendEmailVerification();
        FirebaseReference().userDetail.doc(value.user!.uid).set({
          "id": value.user!.uid,
          "email": email,
          "onlineStatus": "offline",
          "username": username,
          "profile": "",
          "joindata":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        }).then((value) {
          Get.off(verificationScreen());
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CommanDialog.hideLoading();
        CommanDialog.showErrorDialog(
            title: "Password Weak",
            description: "The password provided is too weak.");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommanDialog.hideLoading();
        print('The account already exists for that email.');
        CommanDialog.showErrorDialog(
            title: "Account already",
            description: "The account already exists on your device.");
      }
    } catch (e) {
      print(e);
    }
  }
}

class Verification_Controller extends ChangeNotifier {
  bool _loading = false;
  get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void Verification(BuildContext context) async {
    setLoading(true);
    try {
      final user =
          await auth.currentUser!.sendEmailVerification().then((value) {
        setLoading(false);
        // Utils.flushBarMessage("Email has been send check your email",context);
      });
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }
}

class forgot_Controller extends ChangeNotifier {
  bool _loading = false;

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void forgot(String email, BuildContext context) async {
    setLoading(true);
    CommanDialog.showLoading();
    try {
      final user = await auth
          .sendPasswordResetEmail(
        email: email,
      )
          .then((value) {
        setLoading(false);
        CommanDialog.hideLoading();
        Utils.flushBarMessage(
            "Please check your email to recover your password.", context);
        Get.off(loginScreen());
      });
    } on FirebaseAuthException catch (e) {
      CommanDialog.hideLoading();
      if (e.code == 'user-not-found') {
        CommanDialog.showErrorDialog(
            title: "User not found",
            description: "No user found for that email.");
      } else {
        CommanDialog.showErrorDialog(
            title: "Oops Error", description: e.toString());
        CommanDialog.hideLoading();
      }
    } catch (e) {
      print(e);
    }
  }
}

class siginGoogle extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  signInGoogle() async {
    CommanDialog.showLoading();
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      CommanDialog.hideLoading();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        SessionControler().userId = value.user!.uid.toString();
        FirebaseReference().userDetail.doc(value.user!.uid).set({
          "id": value.user!.uid,
          "email": auth.currentUser!.email,
          "onlineStatus": "",
          "username": auth.currentUser!.displayName,
          "profile": auth.currentUser!.photoURL,
          "joindata":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        }).then((value) {
          CommanDialog.hideLoading();
          Get.off(dashboardScreen());
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

class siginphoneNumber extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  final usernameController = TextEditingController();
  final phoneController = TextEditingController();

  void siginPhone(String? phoneNumber) async {
    try {
      CommanDialog.showLoading();
      auth.verifyPhoneNumber(
          // timeout: const Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: (_) {},
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              CommanDialog.hideLoading();
              CommanDialog.showErrorDialog(
                  title: "Oops Error",
                  description: 'The provided phone number is not valid.');
              print('The provided phone number is not valid.');
            } else {
              CommanDialog.hideLoading();
              return CommanDialog.showErrorDialog(
                  title: "Oops Error", description: 'Something Wrong');
            }
          },
          codeSent: (String verificationId, int? token) {
            Get.to(phoneVerificationscreen(verificationId: verificationId));
          },
          codeAutoRetrievalTimeout: (e) {
            // CommanDialog.hideLoading();
            // CommanDialog.showErrorDialog(title: "Oops Error" ,description: 'Timed out waiting for SMS');
          });
    } catch (e) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog(
          title: "Oop Error", description: e.toString());
    }
  }
}
