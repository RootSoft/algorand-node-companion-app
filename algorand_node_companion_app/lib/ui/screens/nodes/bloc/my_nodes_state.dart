import 'package:equatable/equatable.dart';
import 'package:nodex_companion_app/models/models.dart';

abstract class MyNodesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyNodesInitial extends MyNodesState {}

class MyNodesInProgress extends MyNodesState {}

class MyNodesSuccess extends MyNodesState {
  final List<Node> nodes;
  final DateTime lastUpdated;

  MyNodesSuccess({
    required this.nodes,
  }) : lastUpdated = DateTime.now();

  @override
  List<Object?> get props => [lastUpdated, ...nodes];
}

class MyNodesRefreshed extends MyNodesSuccess {
  MyNodesRefreshed({
    required List<Node> nodes,
  }) : super(nodes: nodes);
}
