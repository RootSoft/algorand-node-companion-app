import 'dart:typed_data';

import 'package:algorand_node_companion_app/database/entities.dart';
import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';

part 'account_entity.g.dart';

@HiveType(typeId: accountTypeId, adapterName: 'AccountAdapter')
class AccountEntity extends HiveObject implements BoxEntity<AlgorandAccount> {
  @HiveField(0)
  late String publicAddress;

  @HiveField(1)
  late Uint8List? privateKey;

  @HiveField(2)
  late bool registered;

  AccountEntity();

  AccountEntity.account(AlgorandAccount account) {
    this.publicAddress = account.publicAddress;
    this.privateKey = account.privateKey;
    this.registered = account.registered;
  }

  void merge(AlgorandAccount account) {
    this.publicAddress = account.publicAddress;
    this.privateKey = account.privateKey;
    this.registered = account.registered;
  }

  @override
  AlgorandAccount unwrap() {
    return AlgorandAccount(
      key: key,
      publicAddress: publicAddress,
      privateKey: privateKey,
      registered: registered,
    );
  }
}
