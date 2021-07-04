import 'package:nodex_companion_app/blocs/navigation/navigation.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/screens/main/main.dart';
import 'package:provider/provider.dart';

class MobileMainScreen extends StatelessWidget {
  const MobileMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          final navigationTab = context.watch<NavigationBloc>().currentTab;
          final index = tabs.indexOf(navigationTab);
          return IndexedStack(
            index: index,
            children: tabHandlers.values.toList(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            context.select((NavigationBloc bloc) => tabs.indexOf(bloc.state)),
        elevation: 6.0,
        backgroundColor: Palette.backgroundNavigationColor,
        selectedItemColor: Palette.primaryColor,
        unselectedItemColor: Palette.inactiveColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          context.read<NavigationBloc>().changeTab(tabs[index]);
        },
        items: tabs
            .map(
              (tab) => BottomNavigationBarItem(
                label: tab.label,
                icon: tab.icon,
              ),
            )
            .toList(),
      ),
    );
  }
}
