import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';

/// Update the node.
class UpdateNodeHandler extends Handler {
  @override
  String get name => 'update-node';

  @override
  Future<bool> resolve(Node node, Parameters parameters) {
    final shell = node.shell;
    final c = Completer<bool>();

    shell
        .run('''./update.sh -u -d data''')
        .then((value) => c.complete(true))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }
}
