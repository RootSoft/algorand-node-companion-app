import 'package:nodex_companion_app/node/menu/node_menu.dart';
import 'package:nodex_companion_app/shared/shared.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/buttons/button.dart';
import 'package:nodex_companion_app/ui/components/dividers/dividers.dart';
import 'package:nodex_companion_app/ui/components/loaders/loader.dart';
import 'package:nodex_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:nodex_companion_app/ui/components/node/card/node_card_header.dart';
import 'package:nodex_companion_app/ui/components/node/card/node_property_tile.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:provider/provider.dart';

class NodeCard extends StatefulWidget {
  const NodeCard({
    Key? key,
  }) : super(key: key);

  @override
  _NodeCardState createState() => _NodeCardState();
}

class _NodeCardState extends State<NodeCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Builder(
          builder: (_) {
            final state = context.watch<NodeCardBloc>().state;
            final node = state.node;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NodeCardHeader(
                  node: node,
                  onMenuTap: () {
                    _showMenu(state.menu);
                  },
                ),
                VerticalSpacing(of: 6.0),
                Builder(
                  builder: (_) {
                    if (node.status == NodeStatus.NOT_CONNECTED) {
                      return _buildTryAgain();
                    }

                    if (node.status == NodeStatus.CONNECTING) {
                      return SizedBox(height: 150, child: Loader());
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.properties.all.length,
                      itemBuilder: (_, index) {
                        final property = state.properties.all[index];
                        return NodePropertyTile(
                          title: property.title,
                          value: property.value ?? '',
                          color: property.data['color'],
                        );
                      },
                      separatorBuilder: (_, index) => HorizontalDivider(),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _showMenu(NodeMenu menu) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Palette.backgroundNavigationColor,
      isScrollControlled: true,
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Build the menu items
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: menu.all
                  .map(
                    (menuItem) => ListTile(
                      leading: menuItem.icon,
                      title: Text(
                        menuItem.title,
                        style: mediumTextStyle.apply(
                          color: menuItem.data['color'],
                        ),
                      ),
                      horizontalTitleGap: paddingSizeSmall,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: paddingSizeMedium,
                      ),
                      onTap: () async {
                        router.pop(context);
                        await menuItem.onTap(context, error: () {});
                      },
                    ),
                  )
                  .toList(),
            ),

            /// Build the cancel button
            Padding(
              padding: EdgeInsets.all(paddingSizeDefault),
              child: Button(
                text: 'Cancel',
                color: Palette.secondaryButtonBackgroundColor,
                highlightColor: const Color(0xFFDBDBE0),
                textColor: Palette.secondaryTextColor,
                onTap: () {
                  router.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTryAgain() {
    return Container(
      height: 150,
      padding: EdgeInsets.all(paddingSizeDefault),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Unable to connect with Algorand Node.',
          ),
          VerticalSpacing(of: marginSizeDefault),
          Button(
            text: 'Try again',
            onTap: () {
              context.read<NodeCardBloc>().connect();
            },
          )
        ],
      ),
    );
  }
}
