import 'dart:async';

import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/node/menu/node_menu_component.dart';
import 'package:nodex_companion_app/shared/shared.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/buttons/button.dart';
import 'package:nodex_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:nodex_companion_app/ui/components/node/network/node_network_group.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:nodex_companion_app/utils/dialogs.dart';
import 'package:provider/provider.dart';

class SwitchNetworkMenuItem extends NodeMenuComponent {
  SwitchNetworkMenuItem()
      : super(
          key: 'switch-network',
          title: 'Switch network',
          icon: HeroIcon(
            HeroIcons.switchHorizontal,
            color: Palette.secondaryTextColor,
          ),
        );

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    final node = context.read<NodeCardBloc>().state.node;
    NodeNetwork network = node.network;

    showAlgorandBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(paddingSizeDefault),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Palette.backgroundOnPrimary,
                  shape: BoxShape.circle,
                ),
                child: HeroIcon(
                  HeroIcons.switchHorizontal,
                  size: 80.0,
                  color: const Color(0xFF1DAD98),
                ),
              ),
              VerticalSpacing(of: 28.0),
              Text(
                'Switch network',
                style: semiBoldTextStyle,
                textAlign: TextAlign.center,
              ),
              VerticalSpacing(of: paddingSizeDefault),
              NodeNetworkGroup(
                network: node.network,
                onChanged: (n) {
                  network = n;
                },
              ),
              VerticalSpacing(of: marginSizeSmall),
              Button(
                text: 'Switch network',
                color: Palette.secondaryButtonBackgroundColor,
                highlightColor: const Color(0xFFDBDBE0),
                textColor: Palette.secondaryTextColor,
                onTap: () {
                  context.read<NodeCardBloc>().switchNetwork(network: network);
                  router.pop(context);
                },
              ),
              VerticalSpacing(of: paddingSizeDefault),
            ],
          ),
        );
      },
    );

    return Future.value(true);
  }
}
