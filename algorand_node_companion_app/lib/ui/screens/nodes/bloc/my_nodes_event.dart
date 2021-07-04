import 'package:equatable/equatable.dart';
import 'package:nodex_companion_app/models/models.dart';

abstract class MyNodesEvent extends Equatable {
  const MyNodesEvent();
  @override
  List<Object?> get props => [];
}

class MyNodesStarted extends MyNodesEvent {}

class MyNodesRefreshStarted extends MyNodesEvent {}

class MyNodesNodeSaved extends MyNodesEvent {
  final Node node;

  const MyNodesNodeSaved({required this.node});

  @override
  List<Object> get props => [node];

  @override
  String toString() => 'MyNodesNodeSaved { node: $node }';
}

class MyNodesNodeRemoved extends MyNodesEvent {
  final dynamic key;

  const MyNodesNodeRemoved({required this.key});

  @override
  List<Object> get props => [key];

  @override
  String toString() => 'MyNodesNodeRemoved { key: $key }';
}
