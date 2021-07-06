import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/buttons/button.dart';
import 'package:algorand_node_companion_app/ui/components/spacing/spacing.dart';
import 'package:algorand_node_companion_app/ui/screens/screens.dart';
import 'package:heroicons/heroicons.dart';

class EmptyAccountsPage extends StatelessWidget {
  const EmptyAccountsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: paddingSizeMedium,
        vertical: paddingSizeDefault,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeroIcon(
            HeroIcons.userGroup,
            size: 48,
            color: Palette.primaryIconTintColor,
          ),
          VerticalSpacing(of: paddingSizeLarge),
          Text(
            'Import an account',
            style: semiBoldTextStyle.copyWith(
              fontSize: fontSizeMedium,
            ),
            textAlign: TextAlign.center,
          ),
          VerticalSpacing(of: paddingSizeNormal),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 36),
            child: Text(
              'Import your first account to sign key registration transactions or add a watch account to sign transactions offline.',
              style: regularTextStyle.copyWith(
                color: Palette.tertiaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          VerticalSpacing(of: paddingSizeLarge),
          Button(
            text: 'Import account',
            onTap: () {
              router.navigateTo(context, ImportAccountScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
