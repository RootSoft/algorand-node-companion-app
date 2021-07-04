import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/themes/themes.dart';

class IconContainer extends StatelessWidget {
  final HeroIcons icon;
  final double size;
  final double iconPadding;
  final Color color;
  final Color backgroundColor;

  const IconContainer({
    required this.icon,
    this.size = 80.0,
    this.iconPadding = 16.0,
    this.color = Palette.primaryIconTintColor,
    this.backgroundColor = Palette.backgroundOnPrimary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(iconPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: HeroIcon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}
