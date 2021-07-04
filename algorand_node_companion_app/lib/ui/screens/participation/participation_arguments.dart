import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/node/nodex_client.dart';

class ParticipationArguments {
  final Node node;
  final NodeXClient client;

  ParticipationArguments({required this.node, required this.client});
}
