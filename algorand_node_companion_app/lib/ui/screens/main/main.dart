import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/screens/accounts/accounts.dart';
import 'package:nodex_companion_app/ui/screens/accounts/accounts_page.dart';
import 'package:nodex_companion_app/ui/screens/metrics/metrics.dart';
import 'package:nodex_companion_app/ui/screens/nodes/my_nodes.dart';

export 'main_screen.dart';
export 'mobile_main_screen.dart';

Widget provideMetricsPage() => MetricsPage();

Widget provideNodeMonitorPage() => BlocProvider<MyNodesBloc>(
      create: (_) => MyNodesBloc(
        nodeRepository: sl.get<NodeRepository>(),
      )..start(),
      child: MyNodesPage(),
    );

Widget provideAccountsPage() => BlocProvider<AccountsBloc>(
      create: (_) => AccountsBloc(
        accountRepository: sl.get<AccountRepository>(),
      )..start(),
      child: AccountsPage(),
    );
