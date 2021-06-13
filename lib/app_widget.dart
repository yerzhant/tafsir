import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: const Color(0xff0088c7),
        accentColor: const Color(0xff0088c7),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          headline6: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.3,
            letterSpacing: -.2,
            fontWeight: FontWeight.w600,
            color: const Color(0xff0a0a0a),
          ),
          subtitle1: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: const Color(0xffbdbdc2),
          ),
          subtitle2: GoogleFonts.lato(
            fontSize: 12,
            letterSpacing: .2,
            fontWeight: FontWeight.w400,
            color: const Color(0x4d0a0a0a),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ).modular();
  }
}
