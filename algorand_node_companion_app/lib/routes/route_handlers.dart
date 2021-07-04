import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/blocs/navigation/navigation.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/routes/routes.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/screens/accounts/import/bloc/import_account_bloc.dart';
import 'package:nodex_companion_app/ui/screens/main/main.dart';
import 'package:nodex_companion_app/ui/screens/nodes/form/node_form.dart';
import 'package:nodex_companion_app/ui/screens/participation/bloc/participation_bloc.dart';
import 'package:nodex_companion_app/ui/screens/participation/participation_arguments.dart';
import 'package:nodex_companion_app/ui/screens/screens.dart';

var rootHandler = Handler(
  type: HandlerType.route,
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (_) => NavigationBloc(tabs[0]),
        ),
      ],
      child: MainScreen(),
    );
  },
);

var welcomeHandler = Handler(
  type: HandlerType.route,
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return WelcomeScreen();
  },
);

var nodeFormHandler = Handler(
  type: HandlerType.route,
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    final node = context?.settings?.arguments as Node?;
    return MultiBlocProvider(
      providers: [
        BlocProvider<NodeFormBloc>(
          create: (_) => NodeFormBloc(
            node: node,
            nodeRepository: sl.get<NodeRepository>(),
          )..start(),
        ),
      ],
      child: NodeFormScreen(),
    );
  },
);

var consensusHandler = Handler(
  type: HandlerType.route,
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    final arguments = context?.settings?.arguments as ParticipationArguments?;

    if (arguments == null)
      throw Exception(
          'Participation arguments not passed as a parameter in route');

    return MultiBlocProvider(
      providers: [
        BlocProvider<ParticipationBloc>(
          create: (_) => ParticipationBloc(
            node: arguments.node,
            client: arguments.client,
            accountRepository: sl.get<AccountRepository>(),
          ),
        ),
      ],
      child: ParticipationScreen(),
    );
  },
);

var importAccountHandler = Handler(
  type: HandlerType.route,
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    final node = context?.settings?.arguments as Node?;
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImportAccountBloc>(
          create: (_) => ImportAccountBloc(
            accountRepository: sl.get<AccountRepository>(),
          ),
        ),
      ],
      child: ImportAccountScreen(),
    );
  },
);
