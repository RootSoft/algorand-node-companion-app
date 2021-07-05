import 'package:hive/hive.dart';
import 'package:nodex_companion_app/database/entities.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';

class AccountBox extends BaseRepository<AlgorandAccount> {
  final Box<AccountEntity> box;

  AccountBox({required this.box});

  @override
  Future<int?> add(AlgorandAccount account) async {
    if (this.boxIsClosed) return null;

    //Write operations are asynchronous but the new values are immediately available
    return await box.add(AccountEntity.account(account));
  }

  @override
  Future<void> remove(id) async {
    if (this.boxIsClosed) return null;

    return await box.delete(id);
  }

  @override
  AlgorandAccount? findById(id) {
    return box.get(id)?.unwrap();
  }

  AlgorandAccount? findByAddress(String address) {
    try {
      final account = box.values
          .where((account) => account.publicAddress == address)
          .first
          .unwrap();
      return account;
    } on StateError {
      return null;
    }
  }

  @override
  AlgorandAccount? first() {
    if (this.boxIsClosed) return null;

    //Read operations for normal boxes are synchronous
    try {
      return box.getAt(0)?.unwrap();
    } on RangeError {
      return null;
    }
  }

  @override
  Future<void> store(key, AlgorandAccount account) async {
    if (this.boxIsClosed) return null;

    //Write operations are asynchronous but the new values are immediately available
    return await box.put(key, AccountEntity.account(account));
  }

  @override
  Future<void> clear() async {
    await box.clear();
  }

  @override
  Iterable<AlgorandAccount> all() {
    return box.values.map((entity) => entity.unwrap()).toList();
  }

  Future<AlgorandAccount?> save(AlgorandAccount account) async {
    if (this.boxIsClosed) return null;
    final entity = box.get(account.key);
    if (entity == null) {
      final key = await add(account);
      return account.copyWith(key: key);
    }

    entity.merge(account);
    entity.save();
    return account.copyWith(key: entity.key);
  }

  bool get boxIsOpen => this.box.isOpen;
  bool get boxIsClosed => !(this.box.isOpen);
}
