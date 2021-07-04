import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/themes/themes.dart';

class CircleActionButton extends StatelessWidget {
  /// The padding around the button's icon. The entire padded icon will react
  /// to input gestures.
  ///
  /// This property must not be null. It defaults to 8.0 padding on all sides.
  final EdgeInsetsGeometry padding;

  final HeroIcons icon;

  final double radius;

  final double iconSize;

  final Color? backgroundColor;

  final Color? iconColor;

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback? onPressed;

  const CircleActionButton({
    required this.onPressed,
    this.icon = HeroIcons.plus,
    this.padding = const EdgeInsets.all(10.0),
    this.radius = 40,
    this.iconSize = 24,
    this.backgroundColor,
    this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: radius,
        height: radius,
        child: new RawMaterialButton(
          fillColor: backgroundColor,
          shape: new CircleBorder(),
          elevation: 0.0,
          child: HeroIcon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
