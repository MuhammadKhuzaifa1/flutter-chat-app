import 'package:chatapp/controllers/chat_controller.dart';
import 'package:chatapp/screens/chatscreens/call_screen/splash_screen.dart';
import 'package:chatapp/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

void main() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// 1/5: define a navigator key
  final navigatorKey = GlobalKey<NavigatorState>();

  /// 2/5: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

final themeProvider = ThemeProvider();

class MyApp extends StatefulWidget {
  static const String title = 'Light & Dark Theme';
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: siginGoogle()),
        ChangeNotifierProvider.value(value: usermessage()),
        ChangeNotifierProvider.value(value: ThemeProvider()),
      ],
      child: GetMaterialApp(
        title: MyApp.title,
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        themeMode: themeProvider.themeMode,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: MyThemes.darkTheme,
        home: SplashScreen(),

        /// 3/5: register the navigator key to MaterialApp
        navigatorKey: widget.navigatorKey,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              child!,

              /// support minimizing
              ZegoUIKitPrebuiltCallMiniOverlayPage(
                contextQuery: () {
                  return widget.navigatorKey.currentState!.context;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
