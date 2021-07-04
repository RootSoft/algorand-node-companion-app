import 'dart:io';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';
import 'package:nodex_server/models/node_network.dart';
import 'package:nodex_server/server/server_settings.dart';
import 'package:process_run/shell.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NodeServer {
  final ServerSettings settings;
  final ShellLinesController _controller = ShellLinesController();
  final List<Handler> handlers;

  NodeServer({
    required this.settings,
    List<Handler>? handlers,
  }) : handlers = handlers ?? [] {
    if (settings.debug) {
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

  /// Start the server
  void start() async {
    final handler = webSocketHandler((WebSocketChannel channel) {
      final server = Server(channel.cast<String>());

      for (var handler in handlers) {
        server.registerMethod(handler.name, (Parameters params) async {
          try {
            final value = params.value;
            final data = value is Map ? params.asMap : {};
            final workingDirectory =
                data['working-directory'] ?? settings.workingDirectory;
            final network = parseGenesis(data['network'] ?? '');

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

    final server =
        await shelf_io.serve(handler, settings.ipAddress, settings.port);
    print('Serving at ws://${server.address.host}:${server.port}');
  }
}
