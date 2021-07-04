import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/themes/algorand_icons.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';

class NodeCardHeader extends StatelessWidget {
  final Node node;
  final VoidCallback? onMenuTap;

  const NodeCardHeader({
    required this.node,
    this.onMenuTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Palette.backgroundOnPrimary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            node.operatingSystem?.icon ?? AlgorandIcons.linux,
            color: Palette.accentColor,
          ),
          HorizontalSpacing(of: paddingSizeNormal),
          Expanded(
            child: Text(
              node.name,
              style: mediumTextStyle.copyWith(
                color: Palette.tertiaryTextColor,
              ),
              maxLines: 1,
            ),
          ),
          HorizontalSpacing(of: paddingSizeNormal),
          InkWell(
            onTap: onMenuTap,
            child: HeroIcon(
              HeroIcons.dotsHorizontal,
              color: Palette.tertiaryIconTintColor,
            ),
          ),
        ],
      ),
    );
  }
}
