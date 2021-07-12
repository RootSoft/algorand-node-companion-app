import 'dart:async';

import 'package:algorand_node_companion_app/constants.dart';
import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/node/nodex_client.dart';
import 'package:algorand_node_companion_app/repositories/repositories.dart';
import 'package:algorand_node_companion_app/shared/shared.dart';
import 'package:algorand_node_companion_app/ui/screens/nodes/form/bloc/node_form_event.dart';
import 'package:algorand_node_companion_app/ui/screens/nodes/form/bloc/node_form_state.dart';
import 'package:algorand_node_companion_app/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NodeFormBloc extends Bloc<NodeFormEvent, NodeFormState> {
  final NodeRepository _nodeRepository;

  NodeFormBloc({
    required Node? node,
    required NodeRepository nodeRepository,
  })  : this._nodeRepository = nodeRepository,
        super(NodeFormInitial(node: node));

  final form = FormGroup({
    'name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'ip-address': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'port': FormControl<String>(
      validators: [NullableNumberValidator().validate],
    ),
    'token': FormControl<String>(
      validators: [],
    ),
    'working-directory': FormControl<String>(
      validators: [],
    ),
  });

  void start() {
    add(NodeFormStarted());
  }

  void addNode() {
    final name = this.form.control('name').value;
    final ipAddress = this.form.control('ip-address').value;
    final port = this.form.control('port').value as String?;
    final token = this.form.control('token').value as String?;
    final workingDirectory = this.form.control('working-directory').value;

    // Mark all controls as touched
    form.markAllAsTouched();

    if (form.hasErrors) return;

    // Unfocus the form
    form.unfocus();

    add(NodeFormSubmitted(
      name: name,
      ipAddress: ipAddress,
      port: port,
      token: token,
      workingDirectory: workingDirectory,
    ));
  }

  @override
  Stream<NodeFormState> mapEventToState(NodeFormEvent event) async* {
    final currentState = state;
    if (event is NodeFormStarted) {
      final node = currentState.node;
      if (node != null) {
        this.form.control('name').value = node.name;
        this.form.control('ip-address').value = node.ipAddress;
        this.form.control('port').value = node.port.toString();
        this.form.control('token').value = node.token;
        this.form.control('working-directory').value = node.workingDirectory;
      }
    }

    if (event is NodeFormSubmitted) {
      yield* _mapConnectToState(
        name: event.name,
        ipAddress: event.ipAddress,
        port: int.tryParse(event.port ?? '$kPortDefault') ?? kPortDefault,
        token: event.token,
        workingDirectory: event.workingDirectory,
      );
    }
  }

  Stream<NodeFormState> _mapConnectToState({
    required String name,
    required String ipAddress,
    required int port,
    required String? token,
    required String? workingDirectory,
  }) async* {
    final currentState = state;
    yield NodeFormInProgress(node: currentState.node);

    try {
      // Connect with the node
      final client = NodeXClient();
      final connected = await client.connect(
        ipAddress,
        port: port,
        token: token,
        workingDirectory: workingDirectory,
      );
      print('connected: $connected');
      if (!connected) {
        yield NodeFormFailure(node: currentState.node);
        return;
      }

      // Save the node in the repository
      final editedNode = currentState.node;
      final savedNode = await _nodeRepository.save(
        editedNode == null
            ? Node(
                name: name,
                ipAddress: ipAddress,
                network: NodeNetwork.MAINNET,
                port: port,
                token: token,
                workingDirectory: workingDirectory,
              )
            : editedNode.copyWith(
                name: name,
                ipAddress: ipAddress,
                port: port,
                token: token,
                workingDirectory: workingDirectory,
              ),
      );

      yield NodeFormSuccess(node: savedNode);

      client.close();
    } catch (ex) {
      yield NodeFormFailure(node: currentState.node);
    }
  }
}
