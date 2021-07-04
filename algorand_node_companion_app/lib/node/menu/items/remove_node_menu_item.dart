import 'dart:async';

import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/node/menu/node_menu_component.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/buttons/button.dart';
import 'package:nodex_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:nodex_companion_app/utils/dialogs.dart';
import 'package:provider/provider.dart';

class RemoveNodeMenuItem extends NodeMenuComponent {
  RemoveNodeMenuItem()
      : super(
          key: 'remove-node',
          title: 'Remove node',
          icon: HeroIcon(
            HeroIcons.trash,
            color: Palette.errorColor,
          ),
          data: {'color': Palette.errorColor},
        );

  @override
  Future<bool> onTap(BuildContext context, {Function? error}) async {
    final node = context.read<NodeCardBloc>().state.node;

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
                  color: const Color(0xFF1AE95050),
                  shape: BoxShape.circle,
                ),
                child: HeroIcon(
                  HeroIcons.trash,
                  size: 80.0,
                  color: Palette.errorColor,
                ),
              ),
              VerticalSpacing(of: 28.0),
              Text(
                'You are about to remove this node.\nThis will remove a bookmark and your node will remain operational. Are you sure you want to proceed with this choice?',
                textAlign: TextAlign.center,
              ),
              VerticalSpacing(of: 36.0),
              Button(
                text: 'Remove node',
                color: Palette.errorColor,
                highlightColor: Palette.errorColor,
                onTap: () async {
                  await sl.get<NodeRepository>().remove(node.key);
                  router.pop(context);
                },
              ),
              VerticalSpacing(of: marginSizeNormal),
              Button(
                text: 'Keep it',
                color: Palette.secondaryButtonBackgroundColor,
                highlightColor: const Color(0xFFDBDBE0),
                textColor: Palette.secondaryTextColor,
                onTap: () {
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
