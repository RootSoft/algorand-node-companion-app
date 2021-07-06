import 'dart:convert';
import 'dart:io';

import 'package:algorand_node_companion_app/database/boxes.dart';
import 'package:algorand_node_companion_app/database/entities.dart';
import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/shared/shared.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BoxModule {
  BoxModule() {
    Hive.registerAdapter(AccountAdapter());
    Hive.registerAdapter(NodeAdapter());
    Hive.registerAdapter(NetworkAdapter());
    Hive.registerAdapter(OperatingSystemAdapter());
  }

  Future<AccountBox> provideAccountBox() async {
    if (kIsWeb) {
      final box = await Hive.openBox<AccountEntity>('accounts');
      return AccountBox(box: box);
    }

    if (Platform.isAndroid || Platform.isIOS) {
      final encryptionKey = await getEncryptionKey();
      final box = await Hive.openBox<AccountEntity>(
        'accounts',
        encryptionCipher: HiveAesCipher(
          base64Url.decode(encryptionKey),
        ),
      );
      return AccountBox(box: box);
    }

    final box = await Hive.openBox<AccountEntity>('accounts');
    return AccountBox(box: box);
  }

  Future<NodeBox> provideNodeBox() async {
    final box = await Hive.openBox<NodeEntity>('nodes');
    return NodeBox(box: box);
  }

  Future<String> getEncryptionKey() async {
    final secureStorage = FlutterSecureStorage();
    var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }
    final encryptedKey = await secureStorage.read(key: 'key');
    return encryptedKey ?? '';
  }
}
