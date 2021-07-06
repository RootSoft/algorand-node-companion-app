import 'package:algorand_node_companion_app/shared/shared.dart';
import 'package:equatable/equatable.dart';

abstract class NodeCardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NodeCardStarted extends NodeCardEvent {}

class NodeCardConnectStarted extends NodeCardEvent {}

class NodeCardStatusUpdated extends NodeCardEvent {
  final NodeInformation? status;

  NodeCardStatusUpdated({this.status});

  @override
  List<Object?> get props => [status];
}

class NodeCardNetworkSwitched extends NodeCardEvent {
  final NodeNetwork network;

  NodeCardNetworkSwitched({required this.network});

  @override
  List<Object?> get props => [network];
}
