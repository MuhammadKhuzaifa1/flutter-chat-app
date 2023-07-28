import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme_provider.dart';

final text = ThemeProvider().themeMode == ThemeMode.dark
    ? 'DarkTheme'
    : 'LightTheme';



class appTextStyle{


  static TextStyle normalText({Color? colors = Colors.black,double fontsize = 14,FontWeight? fontweight = FontWeight.normal}) => GoogleFonts.alata(
    color: colors ,fontSize:fontsize ,fontWeight: fontweight ,
    );
}
