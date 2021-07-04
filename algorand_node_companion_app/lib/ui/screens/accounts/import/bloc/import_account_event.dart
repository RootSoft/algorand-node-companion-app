import 'package:equatable/equatable.dart';

abstract class ImportAccountEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImportAccountStarted extends ImportAccountEvent {}

class ImportAccountWordChanged extends ImportAccountEvent {
  final int index;
  final String word;

  ImportAccountWordChanged({required this.index, required this.word});

  @override
  List<Object?> get props => [index, word];
}

class ImportAccountClipboardPasted extends ImportAccountEvent {}
