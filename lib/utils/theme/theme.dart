import 'package:eproject_currensee/utils/theme/custom_theme/appbar_theme.dart';
import 'package:eproject_currensee/utils/theme/custom_theme/bottomsheet_theme.dart';
import 'package:eproject_currensee/utils/theme/custom_theme/checkbox_theme.dart';
import 'package:eproject_currensee/utils/theme/custom_theme/chip_theme.dart';
import 'package:eproject_currensee/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:eproject_currensee/utils/theme/custom_theme/outlined_button_theme.dart';
import 'package:eproject_currensee/utils/theme/custom_theme/text_field_theme.dart';
import 'package:eproject_currensee/utils/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lighttextTheme,
    elevatedButtonTheme:TElevatedButtonTheme.lightELevatedButton,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBarTheme.lightAppbarTheme,
    checkboxTheme: TCheckBoxTheme.lightBottomsheetTheme,
    bottomSheetTheme: TBottomsheetTheme.lightBottomsheetTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.lightTextFieldTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darktextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkELevatedButton,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppBarTheme.darkAppbarTheme,
    checkboxTheme: TCheckBoxTheme.darkBottomsheetTheme,
    bottomSheetTheme: TBottomsheetTheme.darkBottomsheetTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.darkTextFieldTheme,
  );
}
