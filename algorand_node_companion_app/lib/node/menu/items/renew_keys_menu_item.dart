import 'dart:async';

import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/node/menu/node_menu_component.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:provider/provider.dart';

class RenewParticipationKeysMenuItem extends NodeMenuComponent {
  RenewParticipationKeysMenuItem()
      : super(
          key: 'renew-participation-keys',
          title: 'Renew participation keys',
          icon: HeroIcon(
            HeroIcons.key,
            color: Palette.secondaryTextColor,
          ),
        );

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    final client = context.read<NodeCardBloc>().client;
    final c = Completer<bool>();

    return c.future;
  }
}
