import 'dart:io';

import 'package:nodex_server/handlers/process_result_parser.dart';
import 'package:nodex_server/models/node_status.dart';
import 'package:nodex_server/models/status_property.dart';
import 'package:nodex_server/utils/parsing_utils.dart';
import 'package:nodex_server/utils/string_utils.dart';
import 'package:process_run/shell.dart';
import 'package:process_run/utils/process_result_extension.dart';

class StatusParser extends ProcessResultParser {
  final Shell shell;

  StatusParser({required this.shell});

  @override
  Map<String, dynamic> parse(List<ProcessResult> results) {
    final lines = results.outLines.toList();

    final currentVersion = lines[0].extractNumber();
    final version = lines[1];

    final lastCommittedBlock = lines
        .findProperty(StatusProperty.LAST_COMMITTED_BLOCK)
        .extractValue()
        .extractNumber();

    final timeSinceLastBlock = lines
        .findProperty(StatusProperty.TIME_SINCE_LAST_BLOCK)
        .extractValue()
        .extractNumber();

    final syncTime = lines
        .findProperty(StatusProperty.SYNC_TIME)
        .extractValue()
        .extractNumber();

    final lastVersion = lines
        .findProperty(StatusProperty.LAST_CONSENSUS_PROTOCOL)
        .extractValue();

    final nextVersion = lines
        .findProperty(StatusProperty.NEXT_CONSENSUS_PROTOCOL)
        .extractValue();

    final nextVersionRound = lines
        .findProperty(StatusProperty.ROUND_FOR_NEXT_CONSENSUS_PROTOCOL)
        .extractValue()
        .extractNumber();

    final nextVersionSupported = lines
        .findProperty(StatusProperty.NEXT_CONSENSUS_PROTOCOL_SUPPORTED)
        .extractValue()
        .parseBool();

    final lastCatchpoint =
        lines.findProperty(StatusProperty.LAST_CATCHPOINT).extractValue();

    final genesisId =
        lines.findProperty(StatusProperty.GENESIS_ID).extractValue();

    final genesisHash =
        lines.findProperty(StatusProperty.GENESIS_HASH).extractValue();

    final catchpoint =
        lines.findProperty(StatusProperty.CATCHPOINT).extractValue();

    final telemetry = lines.findProperty(StatusProperty.TELEMETRY).isNotEmpty;
    final isSyncing = syncTime != 0;
    final fastCatchup = isSyncing && catchpoint.isNotEmpty;

    final status = resolveNodeStatus(
      hasGenesisHash: genesisHash.isNotEmpty,
      isSyncing: isSyncing,
      fastCatchup: fastCatchup,
    );

    return {
      'status': status.value,
      'current-version': currentVersion,
      'version': version,
      'last-committed-block': lastCommittedBlock,
      'time-since-last-block': timeSinceLastBlock,
      'sync-time': syncTime,
      'last-version': lastVersion,
      'next-version': nextVersion,
      'next-version-round': nextVersionRound,
      'next-version-supported': nextVersionSupported,
      'last-catchpoint': lastCatchpoint,
      'genesis-id': genesisId,
      'genesis-hash': genesisHash,
      'telemetry': telemetry,
      'is-syncing': isSyncing,
      'sync-fast-catchup': fastCatchup,
      'registered': false,
    };
  }

  Future<bool> isParticipating() async {
    return true;
  }
}
