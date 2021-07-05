import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/node/nodex_client.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/buttons/circle_action_button.dart';
import 'package:nodex_companion_app/ui/components/loaders/loader.dart';
import 'package:nodex_companion_app/ui/components/node/card/bloc/node_card_bloc.dart';
import 'package:nodex_companion_app/ui/components/node/card/node_card.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:nodex_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:nodex_companion_app/ui/screens/nodes/empty_nodes_page.dart';
import 'package:nodex_companion_app/ui/screens/nodes/my_nodes.dart';
import 'package:nodex_companion_app/ui/screens/screens.dart';
import 'package:provider/provider.dart';

class MyNodesPage extends StatelessWidget {
  static String routeName = '/nodes';

  const MyNodesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: 'My nodes',
        actions: [
          CircleActionButton(
            backgroundColor: Palette.primaryColor,
            onPressed: () {
              router.navigateTo(context, WelcomeScreen.routeName);
            },
          ),
          HorizontalSpacing(of: paddingSizeDefault / 2),
        ],
      ),
      body: Builder(
        builder: (_) {
          final state = context.watch<MyNodesBloc>().state;

          if (state is MyNodesInProgress) {
            return Loader();
          }

          if (state is! MyNodesSuccess) {
            return Loader();
          }

          if (state.nodes.isEmpty) {
            return EmptyNodesPage();
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<MyNodesBloc>().refresh();
            },
            child: ListView.separated(
              padding: EdgeInsets.all(paddingSizeDefault),
              addAutomaticKeepAlives: true,
              itemCount: state.nodes.length,
              itemBuilder: (_, index) {
                final node = state.nodes[index];
                return BlocProvider<NodeCardBloc>(
                  key: ValueKey(node),
                  create: (_) => NodeCardBloc(
                    node: node,
                    client: NodeXClient(),
                    nodeRepository: sl.get<NodeRepository>(),
                    stream: BlocProvider.of<MyNodesBloc>(context).stream,
                  )..start(),
                  child: NodeCard(),
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: paddingSizeNormal,
              ),
            ),
          );
        },
      ),
    );
  }
}
