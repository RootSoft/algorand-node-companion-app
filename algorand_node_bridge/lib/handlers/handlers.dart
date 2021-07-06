import 'package:algorand_node_bridge/handlers/handshake/handshake_handler.dart';
import 'package:algorand_node_bridge/handlers/install/install_node_handler.dart';
import 'package:algorand_node_bridge/handlers/network/switch_network_handler.dart';
import 'package:algorand_node_bridge/handlers/node/is_running_handler.dart';
import 'package:algorand_node_bridge/handlers/node/restart_node_handler.dart';
import 'package:algorand_node_bridge/handlers/node/start_node_handler.dart';
import 'package:algorand_node_bridge/handlers/node/stop_node_handler.dart';
import 'package:algorand_node_bridge/handlers/node/update_node_handler.dart';
import 'package:algorand_node_bridge/handlers/participation/register_online_handler.dart';
import 'package:algorand_node_bridge/handlers/status/status_handler.dart';
import 'package:algorand_node_bridge/handlers/sync/sync_node_handler.dart';
import 'package:algorand_node_bridge/handlers/telemetry/telemetry_handler.dart';

export 'handler.dart';
export 'handshake/handshake_handler.dart';
export 'install/install_node_handler.dart';
export 'network/switch_network_handler.dart';
export 'node/is_running_handler.dart';
export 'node/restart_node_handler.dart';
export 'node/start_node_handler.dart';
export 'node/stop_node_handler.dart';
export 'node/update_node_handler.dart';
export 'participation/register_online_handler.dart';
export 'status/status_handler.dart';
export 'sync/sync_node_handler.dart';
export 'telemetry/telemetry_handler.dart';

final defaultHandlers = [
  HandshakeHandler(),
  InstallNodeHandler(),
  StartNodeHandler(),
  StopNodeHandler(),
  RestartNodeHandler(),
  UpdateNodeHandler(),
  IsRunningHandler(),
  StatusCommand(),
  TelemetryHandler(),
  SyncNodeHandler(),
  SwitchNetworkHandler(),
  RegisterOnlineHandler(),
];
