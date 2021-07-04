enum StatusProperty {
  LAST_COMMITTED_BLOCK,
  TIME_SINCE_LAST_BLOCK,
  SYNC_TIME,
  LAST_CONSENSUS_PROTOCOL,
  NEXT_CONSENSUS_PROTOCOL,
  ROUND_FOR_NEXT_CONSENSUS_PROTOCOL,
  NEXT_CONSENSUS_PROTOCOL_SUPPORTED,
  LAST_CATCHPOINT,
  GENESIS_ID,
  GENESIS_HASH,
  CATCHPOINT,
  CATCHPOINT_TOTAL_ACCOUNTS,
  CATCHPOINT_ACCOUNTS_PROCESSED,
  CATCHPOINT_ACCOUNTS_VERIFIED,
  TELEMETRY,
}

const statusPropertyEnumMap = {
  StatusProperty.LAST_COMMITTED_BLOCK: 'Last committed block',
  StatusProperty.TIME_SINCE_LAST_BLOCK: 'Time since last block',
  StatusProperty.SYNC_TIME: 'Sync Time',
  StatusProperty.LAST_CONSENSUS_PROTOCOL: 'Last consensus protocol',
  StatusProperty.NEXT_CONSENSUS_PROTOCOL: 'Next consensus protocol',
  StatusProperty.ROUND_FOR_NEXT_CONSENSUS_PROTOCOL:
      'Round for next consensus protocol',
  StatusProperty.NEXT_CONSENSUS_PROTOCOL_SUPPORTED:
      'Next consensus protocol supported',
  StatusProperty.LAST_CATCHPOINT: 'Last Catchpoint',
  StatusProperty.GENESIS_ID: 'Genesis ID',
  StatusProperty.GENESIS_HASH: 'Genesis hash',
  StatusProperty.CATCHPOINT: 'Catchpoint:',
  StatusProperty.CATCHPOINT_TOTAL_ACCOUNTS: 'Catchpoint total accounts',
  StatusProperty.CATCHPOINT_ACCOUNTS_PROCESSED: 'Catchpoint accounts processed',
  StatusProperty.CATCHPOINT_ACCOUNTS_VERIFIED: 'Catchpoint accounts verified',
  StatusProperty.TELEMETRY: 'Remote logging is enabled.',
};

extension StatusPropertyExtension on StatusProperty {
  String get property {
    return statusPropertyEnumMap[this] ?? '';
  }
}
