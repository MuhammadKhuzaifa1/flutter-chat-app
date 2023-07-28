import 'package:chatapp/component/appcolors.dart';
import 'package:chatapp/controllers/chat_controller.dart';
import 'package:chatapp/screens/authentication/login_screen.dart';
import 'package:chatapp/screens/authentication/phone_auth/sigin_phone.dart';
import 'package:chatapp/screens/authentication/stated_screen.dart';
import 'package:chatapp/screens/chatscreens/dashboard_screen.dart';
import 'package:chatapp/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';

void main()async{
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.bottom]);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

final themeProvider = ThemeProvider();

class MyApp extends StatelessWidget {
  static const String title = 'Light & Dark Theme';


  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: siginGoogle()),
        ChangeNotifierProvider.value(value: usermessage()),
        ChangeNotifierProvider.value(value: ThemeProvider()),

      ],
      child: GetMaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        themeMode: themeProvider.themeMode,
        theme: ThemeData(useMaterial3: true, brightness: Brightness.light,),
        darkTheme: MyThemes.darkTheme,
        home:statedScreen(),
      ),
      );
  }
}
