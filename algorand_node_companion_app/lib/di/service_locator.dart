import 'package:algorand_node_companion_app/database/boxes.dart';
import 'package:algorand_node_companion_app/di/modules/modules.dart';
import 'package:algorand_node_companion_app/repositories/repositories.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> register() async {
    // Register the modules
    await _registerModules();

    // Register the boxes
    await _registerBoxes();

    // Register the repositories
    await _registerRepositories();
  }

  /// Register all modules
  static Future<void> _registerModules() async {
    // Create our BoxModule and provide our boxes
    BoxModule boxModule = new BoxModule();
    sl.registerSingleton<BoxModule>(boxModule);

    // Create our RepositoryModule and provide repositories
    RepositoryModule repositoryModule = new RepositoryModule();
    sl.registerSingleton<RepositoryModule>(repositoryModule);

    print('Modules initialized');
  }

  /// Register all boxes
  static Future<void> _registerBoxes() async {
    BoxModule boxModule = sl.get<BoxModule>();

    // Register account box
    final accountBox = await boxModule.provideAccountBox();
    sl.registerSingleton<AccountBox>(accountBox);

    // Register node box
    final nodeBox = await boxModule.provideNodeBox();
    sl.registerSingleton<NodeBox>(nodeBox);

    print('Boxes initialized');
  }

  /// Register all boxes
  static Future<void> _registerRepositories() async {
    final repositoryModule = sl.get<RepositoryModule>();

    // Register account box
    final accountRepository = repositoryModule.provideAccountRepository(
      accountBox: sl.get<AccountBox>(),
    );
    sl.registerSingleton<AccountRepository>(accountRepository);

    // Register node box
    final nodeRepository = repositoryModule.provideNodeRepository(
      nodeBox: sl.get<NodeBox>(),
    );
    sl.registerSingleton<NodeRepository>(nodeRepository);

    print('Repositories initialized');
  }
}
