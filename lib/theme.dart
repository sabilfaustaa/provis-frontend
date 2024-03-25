import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 40.0;

const Color primaryColor = Color(0xff278EA5);
const Color lightColor = Color(0xffF0F0F0);
const Color khakiColor = Color(0xffB3CAD5);

const Color darkPrimaryColor = Color(0xff22364B);
const Color secondaryColor = Color(0xff5FBD9B);
const Color alertColor = Color(0xffFFB154);
const Color priceColor = Color(0xff278EA5);

BoxDecoration gradientAuthBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF377291),
      Color(0xFF2F786E),
      Color(0xFF4DA796),
    ],
  ),
  image: DecorationImage(
    image: AssetImage("assets/background-auth.png"),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      Colors.black.withOpacity(0.05),
      BlendMode.dstATop,
    ),
  ),
);

TextStyle primaryTextStyle = GoogleFonts.montserrat(
  color: primaryColor,
);
TextStyle darkPrimaryTextStyle = GoogleFonts.montserrat(
  color: darkPrimaryColor,
);
TextStyle lightTextStyle = GoogleFonts.montserrat(
  color: lightColor,
);
TextStyle secondaryTextStyle = GoogleFonts.montserrat(
  color: secondaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight bolder = FontWeight.w900;
