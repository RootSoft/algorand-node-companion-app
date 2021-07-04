import 'dart:io';

import 'package:flutter/foundation.dart';

class WorkingDirectory {
  String? workingDirectory;

  WorkingDirectory({
    this.workingDirectory,
  });

  /// Get the path of the working directory.
  String get path {
    return this.workingDirectory ?? '$homePath/node';
  }

  /// Get the home path.
  String get homePath {
    if (kIsWeb) {
      return '';
    }

    final homePath = Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        '';

    return homePath;
  }

  File get goal {
    return File('$path/goal');
  }
}
