import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/sidebar/side_bar_item.dart';

/// The width of the bottom navigation bar.
const double kSideBarWidth = 64.0;

class SideBar extends StatefulWidget {
  final List<SideBarItem> items;
  final Color? backgroundColor;
  final double? elevation;

  final Color? activeColor;
  final Color? inactiveColor;

  /// Called when one of the [items] is tapped.
  ///
  /// The stateful widget that creates the bottom navigation bar needs to keep
  /// track of the index of the selected [BottomNavigationBarItem] and call
  /// `setState` to rebuild the bottom navigation bar with the new [currentIndex].
  final ValueChanged<int>? onTap;

  /// The index into [items] for the current active [BottomNavigationBarItem].
  final int currentIndex;

  const SideBar({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.elevation,
    this.activeColor,
    this.inactiveColor,
    this.onTap,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: true,
      child: Material(
        elevation: widget.elevation ?? 8.0,
        color: widget.backgroundColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: kSideBarWidth),
          child: Material(
            // Splashes.
            type: MaterialType.transparency,
            child: _createContainer(_createTiles()),
          ),
        ),
      ),
    );
  }

  Widget _createContainer(List<Widget> tiles) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: tiles,
      ),
    );
  }

  List<Widget> _createTiles() {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      tiles.add(
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = i;
                });

                widget.onTap?.call(i);
              },
              icon: item.icon,
              color: i == _currentIndex
                  ? widget.activeColor
                  : widget.inactiveColor,
              iconSize: item.size ?? 24.0,
            ),
          ),
        ),
      );
    }

    return tiles;
  }
}
