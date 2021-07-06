import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';

enum ToolbarStyle {
  DEFAULT,
  TAB,
  CLOSE,
}

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final ToolbarStyle style;
  final List<Widget>? actions;
  final VoidCallback? onBackTapped;

  const Toolbar({
    this.title = '',
    this.style = ToolbarStyle.TAB,
    this.actions,
    this.onBackTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Palette.backgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      leading: _buildNavigationButton(),
      toolbarHeight: toolbarHeight,
      title: Text(
        title,
        style: isDefaultStyle ? toolbarStyle : tabToolbarStyle,
      ),
      titleSpacing: paddingSizeDefault,
      centerTitle: isDefaultStyle,
      backgroundColor: Palette.backgroundColor,
      elevation: 0.0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  bool get isDefaultStyle => style == ToolbarStyle.DEFAULT;

  double get toolbarHeight => isDefaultStyle ? 56.0 : 68.0;

  Widget? _buildNavigationButton() {
    if (onBackTapped == null) return null;

    return IconButton(
      onPressed: onBackTapped,
      icon: HeroIcon(
        style == ToolbarStyle.CLOSE ? HeroIcons.x : HeroIcons.chevronLeft,
        color: Palette.primaryIconTintColor,
      ),
    );
  }
}
