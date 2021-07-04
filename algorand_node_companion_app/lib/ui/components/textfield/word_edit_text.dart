import 'package:algorand_dart/algorand_dart.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:reactive_forms/reactive_forms.dart';

class WordEditText extends StatefulWidget {
  static const defaultSymmetricPadding =
      EdgeInsets.symmetric(vertical: paddingSizeNormal);

  final int index;
  final String? text;
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
  final bool focus;
  final ValueChanged<String> onChanged;

  WordEditText({
    required this.index,
    required this.onChanged,
    this.text,
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
    this.focus = false,
  });

  @override
  _WordEditTextState createState() => _WordEditTextState();
}

class _WordEditTextState extends State<WordEditText>
    with AutomaticKeepAliveClientMixin {
  FocusNode _focus = FocusNode();
  Color _fillColor = Palette.backgroundColor;
  bool _validWord = false;

  @override
  void initState() {
    _focus.addListener(() {
      setState(() {
        _fillColor =
            _focus.hasFocus ? Palette.inputFillColor : Palette.backgroundColor;
      });
    });
    if (widget.focus) _focus.requestFocus();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant WordEditText oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      final word = widget.text;
      _validWord = WordList.getLanguage().words.contains(word);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: widget.padding,
      child: Row(
        children: [
          HorizontalSpacing(of: 8.0),
          Text('${widget.index}.'),
          HorizontalSpacing(of: 8.0),
          Expanded(child: _buildTextField()),
          HorizontalSpacing(of: 8.0),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return TextFormField(
        key: Key(widget.text.toString()),
        readOnly: widget.readOnly,
        obscureText: widget.obscureText,
        cursorColor: Palette.accentColor,
        style: inputTextStyle.copyWith(
          color: _validWord ? Palette.primaryTextColor : Palette.errorColor,
        ),
        keyboardType: widget.keyboardType,
        textInputAction: widget.inputAction,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        expands: widget.expands,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.trailingWidget,
          prefixIcon: widget.leadingWidget,
          filled: true,
          fillColor: _fillColor,
        ).applyDefaults(inputDecorationTheme),
        textAlignVertical: TextAlignVertical.top,
        enabled: widget.enabled,
        initialValue: widget.text,
        controller: widget.textEditingController,
        focusNode: _focus,
        onEditingComplete: () => _focus.nextFocus(),
        onChanged: (value) {
          setState(() {
            // Validate that the word is in the word list
            _validWord = WordList.getLanguage().words.contains(value);
            if (_validWord) widget.onChanged(value);
          });
        });
  }

  @override
  bool get wantKeepAlive => true;
}
