import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mycolor.dart';
import 'package:packages_app/core/util/myconstant.dart';

abstract class AppColors {
  static const secondary = Color(0xFF3B76F6);
  static const accent = Color(0xFFD6755B);
  static const textDark = Color(0xFF53585A);
  static const textLigth = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);
  static const textHighlight = secondary;
  static const cardLight = Color(0xFFEEEEEE);
  static const cardDark = Color(0xFF303334);
}

abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  /// Light theme and its settings.
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        visualDensity: visualDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: MyColor.textColor,
            fontFamily: MyConstant.poppinsMedium,
            fontSize: 28,
          ),
          titleMedium: TextStyle(
            color: MyColor.textColor,
            fontSize: 16,
            fontFamily: MyConstant.poppinsMedium,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            color: MyColor.textColor,
            fontFamily: MyConstant.poppinsRegular,
          ),
          bodyLarge: TextStyle(
            fontSize: 14,
            color: MyColor.textColor,
            fontFamily: MyConstant.rubikRegular,
          ),
          bodyMedium: TextStyle(
            fontSize: 11,
            color: MyColor.textColor,
            fontFamily: MyConstant.rubikRegular,
          ),
          bodySmall: TextStyle(
            fontSize: 10,
            color: MyColor.textColor,
            fontFamily: MyConstant.rubikRegular,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        cardColor: AppColors.cardLight,
        iconTheme: const IconThemeData(color: AppColors.iconDark),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: MyColor.textThird, size: 20),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: MyColor.textColor,
            fontSize: 13.5,
            fontFamily: MyConstant.poppinsMedium,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MyColor.primary,
          accentColor: MyColor.primaryAccent,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(fontSize: 12, color: MyColor.textThird),
          hintStyle: TextStyle(
              fontSize: 12, color: MyColor.textThird, letterSpacing: 1.2),
          isDense: true,
          filled: true,
          prefixIconColor: MyColor.textThird,
          fillColor: MyColor.cardBackgroundColor,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: MyColor.inActiveColor, width: 0.3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: MyColor.inActiveColor, width: 0.3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 10),
            ),
            backgroundColor: WidgetStateProperty.all(MyColor.bluePrimary),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          contentTextStyle: TextStyle(
            fontFamily: "Poppins_Regular",
            fontSize: 14,
            color: MyColor.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: MyColor.textColor,
          unselectedLabelColor: MyColor.textThird,
          unselectedLabelStyle: TextStyle(
            color: MyColor.bluePrimary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          labelPadding: EdgeInsets.symmetric(horizontal: 15),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColor.bluePrimary,
            fontSize: 13.5,
          ),
          indicatorColor: MyColor.bluePrimary,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      );

  /// Dark theme and its settings.
  static ThemeData dark() => ThemeData().copyWith(
        visualDensity: visualDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppColors.textLigth,
            fontSize: 17,
          ),
          titleMedium: TextStyle(
            color: AppColors.textLigth,
            fontSize: 11,
            letterSpacing: 0.3,
          ),
          bodyLarge: TextStyle(
            fontSize: 11,
            color: AppColors.textFaded,
          ),
          bodyMedium: TextStyle(
            fontSize: 11,
            color: AppColors.textFaded,
          ),
          bodySmall: TextStyle(
            fontSize: 11,
            color: AppColors.textFaded,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFF1B1E1F),
        cardColor: AppColors.cardDark,
        iconTheme: const IconThemeData(color: AppColors.iconLight),
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(secondary: AppColors.accent)
            .copyWith(surface: const Color(0xFF1B1E1F)),
      );
}
