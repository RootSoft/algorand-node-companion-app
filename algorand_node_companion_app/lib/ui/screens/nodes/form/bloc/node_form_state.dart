import 'package:algorand_node_companion_app/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class NodeFormState extends Equatable {
  final Node? node;

  NodeFormState({required this.node});

  bool get isEditing => node != null;

  @override
  List<Object?> get props => [node];
}

class NodeFormInitial extends NodeFormState {
  NodeFormInitial({required Node? node}) : super(node: node);
}

class NodeFormInProgress extends NodeFormState {
  NodeFormInProgress({required Node? node}) : super(node: node);
}

class NodeFormFailure extends NodeFormState {
  NodeFormFailure({required Node? node}) : super(node: node);
}

class NodeFormSuccess extends NodeFormState {
  NodeFormSuccess({required Node? node}) : super(node: node);
}
