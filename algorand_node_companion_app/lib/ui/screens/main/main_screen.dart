import 'package:algorand_node_companion_app/blocs/navigation/navigation.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/screens/main/main.dart';
import 'package:heroicons/heroicons.dart';
import 'package:responsive_builder/responsive_builder.dart';

final tabHandlers = <NavigationTab, Widget>{
  NavigationTab(label: 'My nodes', icon: HeroIcon(HeroIcons.cubeTransparent)):
      provideNodeMonitorPage(),
  NavigationTab(label: 'Metrics', icon: HeroIcon(HeroIcons.chartBar)):
      provideMetricsPage(),
  NavigationTab(label: 'Accounts', icon: HeroIcon(HeroIcons.creditCard)):
      provideAccountsPage(),
  NavigationTab(label: 'Settings', icon: HeroIcon(HeroIcons.cog)):
      provideSettingsPage(),
};

final tabs = tabHandlers.keys.toList();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileMainScreen(),
      desktop: (BuildContext context) => MobileMainScreen(),
    );
  }
}
