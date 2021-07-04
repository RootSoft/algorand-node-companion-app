import 'package:equatable/equatable.dart';

enum EntityEvent { SAVED, DELETED }

class RepositoryEvent<T> extends Equatable {
  final dynamic key;
  final EntityEvent event;
  final T? entity;

  RepositoryEvent({
    required this.key,
    required this.event,
    this.entity,
  });

  @override
  List<Object?> get props => [key, event, entity];
}
