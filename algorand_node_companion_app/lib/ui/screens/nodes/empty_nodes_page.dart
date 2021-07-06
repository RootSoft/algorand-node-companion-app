import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/buttons/button.dart';
import 'package:algorand_node_companion_app/ui/components/spacing/spacing.dart';
import 'package:algorand_node_companion_app/ui/screens/screens.dart';
import 'package:heroicons/heroicons.dart';

class EmptyNodesPage extends StatelessWidget {
  const EmptyNodesPage({
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
            HeroIcons.cubeTransparent,
            size: 48,
            color: Palette.primaryIconTintColor,
          ),
          VerticalSpacing(of: paddingSizeLarge),
          Text(
            'Monitor your nodes',
            style: semiBoldTextStyle.copyWith(
              fontSize: fontSizeMedium,
            ),
            textAlign: TextAlign.center,
          ),
          VerticalSpacing(of: paddingSizeNormal),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 36),
            child: Text(
              'You need to add your first node to manage and monitor your network.',
              style: regularTextStyle.copyWith(
                color: Palette.tertiaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          VerticalSpacing(of: paddingSizeLarge),
          Button(
            text: 'Add a node',
            onTap: () {
              router.navigateTo(context, WelcomeScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
