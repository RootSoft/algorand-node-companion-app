import 'package:algorand_dart/algorand_dart.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control have a a valid Algorand address.
class AccountValidator extends Validator<dynamic> {
  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = <String, dynamic>{'invalid': true};
    final value = control.value;

    if (value == null) {
      return error;
    } else if (value is String) {
      return Address.isAlgorandAddress(value) ? null : error;
    }

    return null;
  }
}

/// Validator that validates if control's value is a numeric value.
class NullableNumberValidator extends Validator<dynamic> {
  /// The regex expression of a numeric string value.
  static final RegExp numberRegex = RegExp(r'^-?[0-9]+$');

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final value = control.value;
    if (value == null) {
      return null;
    }

    return !numberRegex.hasMatch(value.toString())
        ? <String, dynamic>{ValidationMessage.number: true}
        : null;
  }
}
