import 'dart:io';

abstract class ProcessResultParser {
  Map<String, dynamic> parse(List<ProcessResult> results);
}
