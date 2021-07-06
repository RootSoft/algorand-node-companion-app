import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/spacing/spacing.dart';
import 'package:heroicons/heroicons.dart';

class MenuListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? description;
  final VoidCallback? onTap;

  const MenuListTile({
    required this.title,
    this.description,
    this.leading,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: leading,
        contentPadding: EdgeInsets.all(paddingSizeDefault),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: mediumTextStyle.copyWith(fontSize: fontSizeMedium),
            ),
            VerticalSpacing(
              of: 4.0,
            ),
            Text(
              description ?? '',
              style: regularTextStyle.copyWith(
                color: Palette.secondaryTextColor,
              ),
            )
          ],
        ),
        trailing: HeroIcon(
          HeroIcons.chevronRight,
          color: Palette.secondaryIconTintColor,
        ),
      ),
    );
  }
}
