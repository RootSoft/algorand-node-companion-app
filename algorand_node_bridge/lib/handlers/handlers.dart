import 'package:nodex_server/handlers/handshake/handshake_handler.dart';
import 'package:nodex_server/handlers/install/install_node_handler.dart';
import 'package:nodex_server/handlers/network/switch_network_handler.dart';
import 'package:nodex_server/handlers/node/is_running_handler.dart';
import 'package:nodex_server/handlers/node/restart_node_handler.dart';
import 'package:nodex_server/handlers/node/start_node_handler.dart';
import 'package:nodex_server/handlers/node/stop_node_handler.dart';
import 'package:nodex_server/handlers/participation/register_online_handler.dart';
import 'package:nodex_server/handlers/status/status_handler.dart';
import 'package:nodex_server/handlers/sync/sync_node_handler.dart';
import 'package:nodex_server/handlers/telemetry/telemetry_handler.dart';

export 'handler.dart';
export 'handshake/handshake_handler.dart';
export 'install/install_node_handler.dart';
export 'network/switch_network_handler.dart';
export 'node/is_running_handler.dart';
export 'node/restart_node_handler.dart';
export 'node/start_node_handler.dart';
export 'node/stop_node_handler.dart';
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
  IsRunningHandler(),
  StatusCommand(),
  TelemetryHandler(),
  SyncNodeHandler(),
  SwitchNetworkHandler(),
  RegisterOnlineHandler(),
];
