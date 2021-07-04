import 'package:nodex_companion_app/blocs/navigation/navigation.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/sidebar/side_bar.dart';
import 'package:nodex_companion_app/ui/components/sidebar/side_bar_item.dart';
import 'package:nodex_companion_app/ui/screens/main/main.dart';
import 'package:provider/provider.dart';

class DesktopMainScreen extends StatelessWidget {
  const DesktopMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SideBar(
          elevation: 8.0,
          backgroundColor: Palette.backgroundDarkColor,
          activeColor: Palette.primaryColor,
          inactiveColor: Palette.inactiveColor,
          onTap: (index) {
            context.read<NavigationBloc>().changeTab(tabs[index]);
          },
          items: tabs
              .map(
                (tab) => SideBarItem(
                  label: tab.label,
                  icon: tab.icon,
                ),
              )
              .toList(),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingSizeXXLarge,
              vertical: paddingSizeXLarge,
            ),
            child: Builder(
              builder: (BuildContext context) {
                final navigationTab =
                    context.watch<NavigationBloc>().currentTab;
                final index = tabs.indexOf(navigationTab);
                return IndexedStack(
                  index: index,
                  children: tabHandlers.values.toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
