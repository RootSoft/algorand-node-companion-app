import 'package:algorand_node_companion_app/themes/themes.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Widget? child;
  final Color? color;
  final Color? highlightColor;

  final Color? textColor;

  Button({
    required this.text,
    this.color,
    this.highlightColor,
    this.textColor,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        color: this.color ?? Palette.primaryColor,
        highlightColor: this.highlightColor ?? Palette.primaryDarkColor,
        focusColor: Palette.transparent,
        splashColor: Palette.transparent,
        hoverColor: Palette.transparent,
        disabledElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 12.0),
        child: child ??
            Text(
              text,
              style: buttonTextStyle.copyWith(color: textColor),
            ),
        onPressed: onTap,
      ),
    );
  }
}
