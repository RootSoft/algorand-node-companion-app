import 'package:nodex_companion_app/database/boxes.dart';
import 'package:nodex_companion_app/database/entities.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/shared/shared.dart';
import 'package:nodex_companion_app/themes/themes.dart';

class BoxModule {
  BoxModule() {
    Hive.registerAdapter(AccountAdapter());
    Hive.registerAdapter(NodeAdapter());
    Hive.registerAdapter(NetworkAdapter());
    Hive.registerAdapter(OperatingSystemAdapter());
  }

  Future<AccountBox> provideAccountBox() async {
    final box = await Hive.openBox<AccountEntity>('accounts');
    return AccountBox(box: box);
  }

  Future<NodeBox> provideNodeBox() async {
    final box = await Hive.openBox<NodeEntity>('nodes');
    return NodeBox(box: box);
  }
}
