import 'package:flutter/material.dart';
import 'package:nodex_companion_app/themes/themes.dart';

Future<T?> showAlgorandBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor: Palette.backgroundNavigationColor,
    isScrollControlled: true,
    builder: builder,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar({
  required BuildContext context,
  required String text,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: regularTextStyle.copyWith(color: Palette.primaryButtonTextColor),
      ),
      backgroundColor: Palette.errorColor,
    ),
  );
}
