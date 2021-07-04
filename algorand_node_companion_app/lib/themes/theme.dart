import 'themes.dart';

ThemeData appTheme() {
  return ThemeData(
    /// Brightness
    brightness: Brightness.light,

    /// Colors
    primaryColor: Palette.primaryColor,
    accentColor: Palette.accentColor,
    buttonColor: Palette.primaryColor,
    hintColor: Palette.accentColor,
    primarySwatch: generateMaterialColor(Palette.primaryColor),
    scaffoldBackgroundColor: Palette.backgroundColor,

    /// Text
    fontFamily: "Public Sans",
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    /// Buttons
    //outlinedButtonTheme: outlinedButtonThemeData,
  );
}

var textTheme = TextTheme(
  bodyText1: regularTextStyle,
  bodyText2: regularTextStyle,
  button: regularTextStyle,
);

var inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Palette.inputFillColor,
  hintStyle: hintTextStyle,
  enabledBorder: textFieldBorder,
  focusedBorder: textFieldBorder,
  contentPadding: EdgeInsets.symmetric(
    horizontal: paddingSizeDefault,
    vertical: paddingSizeMedium,
  ),
);

var textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.all(
    Radius.circular(12.0),
  ),
);
