import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/lists/menu_list_tile.dart';
import 'package:algorand_node_companion_app/ui/components/spacing/spacing.dart';
import 'package:algorand_node_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:algorand_node_companion_app/ui/screens/screens.dart';
import 'package:heroicons/heroicons.dart';

class WelcomeScreen extends StatelessWidget {
  static final routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        onBackTapped: () {
          router.pop(context);
        },
      ),
      body: SafeArea(
        child: Builder(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingSizeLarge,
                    vertical: paddingSizeNormal,
                  ),
                  child: Text(
                    'Welcome to the Algorand Node Companion App',
                    style: semiBoldTextStyle.copyWith(fontSize: 28.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                MenuListTile(
                  title: 'Set up a node',
                  description:
                      'First time installing a node? Let\'s help you on the way!',
                  leading: HeroIcon(
                    HeroIcons.plusCircle,
                    size: 32.0,
                    color: Palette.accentColor,
                  ),
                  onTap: () {},
                ),
                MenuListTile(
                  title: 'Monitor a node',
                  description: 'Monitor an existing node on a remote location',
                  leading: HeroIcon(
                    HeroIcons.eye,
                    size: 32.0,
                    color: Palette.accentColor,
                  ),
                  onTap: () {
                    router.navigateTo(context, NodeFormScreen.routeName);
                  },
                ),
                Spacer(),
                Text(
                  'Before you continue, make sure the Algorand Node Bridge is installed on the remote device',
                  style: regularTextStyle.copyWith(
                    color: Palette.tertiaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalSpacing(of: paddingSizeDefault),
              ],
            );
          },
        ),
      ),
    );
  }
}
