import 'package:equatable/equatable.dart';

class ImportAccountState extends Equatable {
  final List<String> words;
  final bool pasted;
  final DateTime lastUpdated;

  ImportAccountState({
    required this.words,
    this.pasted = false,
  }) : lastUpdated = DateTime.now();

  ImportAccountState copyWith({
    List<String>? words,
    bool? pasted,
  }) {
    return ImportAccountState(
      words: words ?? this.words,
      pasted: pasted ?? this.pasted,
    );
  }

  /// Check if all words are filled in.
  bool get areWordsFilledIn => !words.contains('');

  @override
  List<Object?> get props => [lastUpdated];
}

class ImportAccountFailure extends ImportAccountState {
  ImportAccountFailure({
    required ImportAccountState state,
  }) : super(
          words: state.words,
          pasted: state.pasted,
        );
}

class ImportAccountSuccess extends ImportAccountState {
  ImportAccountSuccess({
    required ImportAccountState state,
  }) : super(
          words: state.words,
          pasted: state.pasted,
        );
}
