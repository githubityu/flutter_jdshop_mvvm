import 'package:flutter/material.dart';

class AppTheme {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      useMaterial3: true,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      colorScheme: colorScheme,
      focusColor: focusColor,
      textTheme: _textTheme,
      segmentedButtonTheme: SegmentedButtonThemeData(
          style: ButtonStyle(
              shape: ButtonStyleButton.allOrNull(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.red, width: 1))),
              padding: ButtonStyleButton.allOrNull(EdgeInsets.zero),
              elevation: ButtonStyleButton.allOrNull(0),
              minimumSize: ButtonStyleButton.allOrNull(const Size(50, 35)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.black;
                }
                return Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return Colors.black;
              }))),
      dividerTheme: DividerThemeData(color: Colors.grey.withOpacity(0.3)),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: colorScheme.background,
          foregroundColor: colorScheme.onBackground),
      textButtonTheme: TextButtonThemeData(style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        }
        return colorScheme.onBackground;
      }))),
      scaffoldBackgroundColor: colorScheme.background,
    );
  }

  static ColorScheme lightColorScheme =
      ColorScheme.fromSeed(seedColor: Colors.red)
          .copyWith(background: Colors.white, onBackground: Colors.black);

  static ColorScheme darkColorScheme =
      ColorScheme.fromSeed(seedColor: Colors.red).copyWith(
    background: Colors.black,
    onBackground: Colors.white,
  );

  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = const TextTheme(
    bodyLarge: TextStyle(fontWeight: _bold, fontSize: 16.0),
    bodyMedium: TextStyle(fontWeight: _semiBold, fontSize: 14.0),
    bodySmall: TextStyle(fontWeight: _medium, fontSize: 12.0),
  ).apply(
    fontSizeFactor: 1,
  );
}
