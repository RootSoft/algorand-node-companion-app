import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class AlgorandAccount extends Equatable {
  final int key;
  final String publicAddress;
  final Uint8List? privateKey;
  final bool registered;

  AlgorandAccount({
    this.key = -1,
    required this.publicAddress,
    required this.registered,
    this.privateKey,
  });

  AlgorandAccount copyWith({
    int? key,
    String? name,
    bool? registered,
  }) {
    return AlgorandAccount(
      key: key ?? this.key,
      publicAddress: publicAddress,
      privateKey: privateKey,
      registered: registered ?? this.registered,
    );
  }

  @override
  List<Object?> get props => [key, registered, publicAddress];
}
