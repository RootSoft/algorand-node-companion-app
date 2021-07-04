import 'package:nodex_companion_app/themes/themes.dart';

class HorizontalDivider extends StatelessWidget {
  final EdgeInsets? padding;
  const HorizontalDivider({
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: paddingSizeNormal),
      child: Divider(
        color: Palette.border,
      ),
    );
  }
}
