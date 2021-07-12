import 'package:equatable/equatable.dart';

abstract class NodeFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NodeFormStarted extends NodeFormEvent {}

class NodeFormSubmitted extends NodeFormEvent {
  final String name;
  final String ipAddress;
  final String? port;
  final String? token;
  final String? workingDirectory;

  NodeFormSubmitted({
    required this.name,
    required this.ipAddress,
    this.port,
    this.token,
    this.workingDirectory,
  });

  @override
  List<Object?> get props => [name, ipAddress, port, token, workingDirectory];
}
