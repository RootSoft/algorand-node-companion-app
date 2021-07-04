import 'package:nodex_companion_app/database/boxes.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/themes/themes.dart';

class AccountRepository extends BaseRepository<AlgorandAccount> {
  final AccountBox _accountBox;

  AccountRepository({
    required AccountBox accountBox,
  }) : this._accountBox = accountBox;

  @override
  Future<int?> add(AlgorandAccount account) {
    return _accountBox.add(account);
  }

  @override
  Future<void> remove(id) async {
    return _accountBox.remove(id);
  }

  @override
  AlgorandAccount? findById(id) {
    return _accountBox.findById(id);
  }

  Future<AlgorandAccount?> save(AlgorandAccount account) {
    return _accountBox.save(account);
  }

  @override
  Iterable<AlgorandAccount> all() {
    return _accountBox.all().toList();
  }

  Stream<RepositoryEvent<AlgorandAccount>> get repositoryChanges =>
      _accountBox.box.watch().map(convert);

  RepositoryEvent<AlgorandAccount> convert(BoxEvent event) {
    if (event.deleted) {
      return RepositoryEvent<AlgorandAccount>(
          key: event.key, event: EntityEvent.DELETED);
    }

    final account = findById(event.key);

    return RepositoryEvent<AlgorandAccount>(
      key: event.key,
      event: EntityEvent.SAVED,
      entity: account,
    );
  }
}
