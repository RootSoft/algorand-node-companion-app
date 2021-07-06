import 'package:algorand_node_companion_app/database/boxes.dart';
import 'package:algorand_node_companion_app/repositories/repositories.dart';

/// A module which provides everything related to our repositories.
class RepositoryModule {
  /// Provide an instance of a [GooglePlaceRepository].
  AccountRepository provideAccountRepository({required AccountBox accountBox}) {
    return AccountRepository(accountBox: accountBox);
  }

  /// Provide an instance of a [GooglePlaceRepository].
  NodeRepository provideNodeRepository({required NodeBox nodeBox}) {
    return NodeRepository(nodeBox: nodeBox);
  }
}
