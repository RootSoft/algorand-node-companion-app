import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditText extends StatelessWidget {
  static const defaultSymmetricPadding =
      EdgeInsets.symmetric(vertical: paddingSizeNormal);

  final String? formControlName;
  final String? text;
  final String? label;
  final bool readOnly;
  final bool obscureText;
  final String? hintText;
  final ValidationMessagesFunction? validationMessages;
  final VoidCallback? onSubmitted;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? textEditingController;
  final EdgeInsets padding;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final TextInputType keyboardType;
  final TextInputAction? inputAction;
  final int? minLines;
  final int? maxLines;
  final bool expands;
  final bool enabled;

  EditText({
    this.formControlName,
    this.text,
    this.label,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputAction,
    this.hintText,
    this.validationMessages,
    this.onSubmitted,
    this.onFieldSubmitted,
    this.textEditingController,
    this.padding = defaultSymmetricPadding,
    this.leadingWidget,
    this.trailingWidget,
    this.minLines = 1,
    this.maxLines = 1,
    this.expands = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null)
            Text(
              label ?? '',
              style: labelTextStyle,
            ),
          VerticalSpacing(of: 8),
          formControlName != null
              ? _buildReactiveTextField()
              : _buildTextField()
        ],
      ),
    );
  }

  Widget _buildReactiveTextField() {
    return ReactiveTextField(
      readOnly: readOnly,
      obscureText: obscureText,
      formControlName: formControlName,
      cursorColor: Palette.accentColor,
      style: inputTextStyle,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: trailingWidget,
        prefixIcon: leadingWidget,
      ).applyDefaults(inputDecorationTheme),
      validationMessages: validationMessages,
      onSubmitted: onSubmitted,
      textAlignVertical: TextAlignVertical.top,
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      readOnly: readOnly,
      obscureText: obscureText,
      cursorColor: Palette.accentColor,
      style: inputTextStyle,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: trailingWidget,
        prefixIcon: leadingWidget,
      ).applyDefaults(inputDecorationTheme),
      textAlignVertical: TextAlignVertical.top,
      enabled: enabled,
      initialValue: text,
      controller: textEditingController,
    );
  }
}
