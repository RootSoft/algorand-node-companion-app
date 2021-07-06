import 'dart:io';

import 'package:algorand_node_bridge/handlers/process_result_parser.dart';

class InstallNodeParser extends ProcessResultParser {
  @override
  Map<String, dynamic> parse(List<ProcessResult> results) {
    if (results.length != 3) {
      return {};
    }

    final logs = (results[2].stdout as String).split('\n');

    return {'logs': logs};
  }
}
