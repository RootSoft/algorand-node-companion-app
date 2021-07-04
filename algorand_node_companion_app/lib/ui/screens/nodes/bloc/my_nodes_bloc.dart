import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/ui/screens/nodes/bloc/my_nodes_event.dart';
import 'package:nodex_companion_app/ui/screens/nodes/bloc/my_nodes_state.dart';

class MyNodesBloc extends Bloc<MyNodesEvent, MyNodesState> {
  final NodeRepository _nodeRepository;

  late StreamSubscription<RepositoryEvent<Node>> _boxSubscription;

  MyNodesBloc({
    required NodeRepository nodeRepository,
  })  : _nodeRepository = nodeRepository,
        super(MyNodesInitial()) {
    _buildBoxSubscription();
  }

  /// Start the node monitor.
  void start() {
    add(MyNodesStarted());
  }

  /// Start the node monitor.
  void refresh() {
    add(MyNodesRefreshStarted());
  }

  /// Inserts (or updates) a node in the list.
  void upsertNode(Node? node) {
    if (node == null) return;

    add(MyNodesNodeSaved(node: node));
  }

  /// Removes a node in the list.
  void removeNode(dynamic key) {
    add(MyNodesNodeRemoved(key: key));
  }

  @override
  Stream<MyNodesState> mapEventToState(MyNodesEvent event) async* {
    final currentState = state;
    if (event is MyNodesStarted) {
      yield MyNodesInProgress();

      final nodes = _nodeRepository.all();

      yield MyNodesSuccess(nodes: nodes.toList());
    }

    if (event is MyNodesRefreshStarted) {
      final nodes = _nodeRepository.all();

      yield MyNodesRefreshed(nodes: nodes.toList());
    }

    if (event is MyNodesNodeSaved && currentState is MyNodesSuccess) {
      final nodes = currentState.nodes;
      final index = nodes.indexWhere((node) => node.key == event.node.key);
      if (index > -1) {
        // Update
        nodes[index] = event.node;
      } else {
        nodes.add(event.node);
      }

      yield MyNodesSuccess(nodes: nodes);
    }

    if (event is MyNodesNodeRemoved && currentState is MyNodesSuccess) {
      final nodes = currentState.nodes;
      nodes.removeWhere((node) => node.key == event.key);

      yield MyNodesSuccess(nodes: nodes);
    }
  }

  void _buildBoxSubscription() {
    _boxSubscription = _nodeRepository.repositoryChanges.listen((event) {
      switch (event.event) {
        case EntityEvent.SAVED:
          upsertNode(event.entity);
          break;
        case EntityEvent.DELETED:
          removeNode(event.key);
          break;
      }
    });
  }

  @override
  Future<void> close() {
    _boxSubscription.cancel();
    return super.close();
  }
}
