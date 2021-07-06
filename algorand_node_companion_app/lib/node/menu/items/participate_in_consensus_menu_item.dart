import 'dart:async';

import 'package:heroicons/heroicons.dart';
import 'package:algorand_node_companion_app/node/menu/node_menu_component.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/participation_arguments.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/participation_screen.dart';
import 'package:provider/provider.dart';

class ParticipateInConsensusMenuItem extends NodeMenuComponent {
  ParticipateInConsensusMenuItem()
      : super(
          key: 'participate-consensus',
          title: 'Participate in consensus',
          icon: HeroIcon(
            HeroIcons.globe,
            color: Palette.secondaryTextColor,
          ),
        );

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    final node = context.read<NodeCardBloc>().state.node;
    final client = context.read<NodeCardBloc>().client;
    router.navigateTo(
      context,
      ParticipationScreen.routeName,
      routeSettings: RouteSettings(
        arguments: ParticipationArguments(node: node, client: client),
      ),
    );
    return Future.value(true);
  }
}
