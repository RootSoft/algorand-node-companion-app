import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:nodex_server/controllers/node_controller.dart';
import 'package:nodex_server/handlers/handlers.dart';
import 'package:nodex_server/handlers/install/install_node_parser.dart';

class InstallNodeHandler extends Handler {
  @override
  String get name => 'install-node';

  @override
  Future<Map<String, dynamic>> resolve(Node node, Parameters parameters) async {
    final shell = node.shell;
    final workingDirectory = node.workingDirectory;

    // Install or update the node
    final results = await shell.run('''
        curl https://raw.githubusercontent.com/algorand/go-algorand-doc/master/downloads/installers/update.sh -O
        
        chmod 777 update.sh
        
        ./update.sh -i -c stable -p $workingDirectory -d $workingDirectory/data -n
    ''');

    return InstallNodeParser().parse(results);
  }
}
