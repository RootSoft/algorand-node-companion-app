import 'dart:io';

import 'package:algorand_node_bridge/controllers/node_controller.dart';
import 'package:algorand_node_bridge/handlers/handlers.dart';
import 'package:algorand_node_bridge/models/node_network.dart';
import 'package:algorand_node_bridge/server/server_settings.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:process_run/shell.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NodeServer {
  final ServerSettings settings;
  final ShellLinesController _controller = ShellLinesController();
  final List<Handler> handlers;

  /// A list of valid tokens, to be reworked to JWT's?
  final List<String> tokens = [];

  NodeServer({
    required this.settings,
    List<Handler>? handlers,
  }) : handlers = handlers ?? [] {
    if (settings.verbose) {
      _controller.stream.listen((event) {
        print(event);
      });
    }

    // Create the working directory
    Directory(settings.workingDirectory).createSync(recursive: true);

    // Register the default handlers
    _registerDefaultHandlers();
  }

  void _registerDefaultHandlers() {
    handlers.addAll(defaultHandlers);
  }

  /// Register a new handler.
  void registerHandler(Handler handler) {
    handlers.add(handler);
  }

  /// Unregisters an existing handler.
  void unregisterHandler(Handler handler) {
    handlers.remove(handler);
  }

  /// Register a new authorization token.
  void registerToken(String token) {
    tokens.add(token);
  }

  /// Start the server
  void start() async {
    final handler = webSocketHandler((WebSocketChannel channel) {
      final server = Server(channel.cast<String>());

      for (var handler in handlers) {
        server.registerMethod(handler.name, (Parameters params) async {
          // TODO Pipeline integration
          try {
            final value = params.value;
            final data = value is Map ? params.asMap : {};
            final token = data['token'];
            final workingDirectory =
                data['working-directory'] ?? settings.workingDirectory;
            final network = parseGenesis(data['network'] ?? '');
            if (!tokens.contains(token)) {
              throw RpcException(403, 'Forbidden');
            }

            final shell = Shell(
              workingDirectory: workingDirectory,
              stdout: _controller.sink,
            );

            final node = Node(shell: shell, network: network);

            final response = await handler.resolve(node, params);
            return response;
          } on ShellException catch (ex) {
            throw RpcException(400, ex.message);
          } catch (ex) {
            if (ex is RpcException) rethrow;
            throw RpcException(400, ex.toString());
          }
        });
      }

      server.listen();
    });

    final server = await shelf_io.serve(
      handler,
      settings.ipAddress,
      settings.port,
      securityContext: settings.securityContext,
    );

    print('Serving at $protocol://${server.address.host}:${server.port}');
    if (tokens.isNotEmpty) {
      print('Authorization token: ${tokens.first}');
    }
  }

  /// Check if the server is started with a security context.
  bool get isSecure => settings.securityContext != null;

  /// Get the (prefix) web socket protocol used
  String get protocol => isSecure ? 'wss' : 'ws';
}
