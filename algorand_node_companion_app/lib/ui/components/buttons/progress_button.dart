import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/buttons/argon_button_dart.dart';

typedef OnProgressButtonTapped = Function(ButtonState state);

class ProgressButton extends StatelessWidget {
  final double width;
  final double height;
  final ButtonState state;
  final String text;
  final Function(
      Function startLoading, Function stopLoading, ButtonState btnState) onTap;

  const ProgressButton({
    required this.text,
    required this.onTap,
    this.state = ButtonState.Idle,
    this.width = 200,
    this.height = 46,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      width: width,
      height: height,
      state: state,
      borderRadius: 24.0,
      child: Text(
        text,
        style: buttonTextStyle,
      ),
      loader: Container(
        width: 24,
        height: 24,
        child: FittedBox(
          child: CircularProgressIndicator(
            color: Palette.primaryButtonTextColor,
          ),
        ),
      ),
      onTap: (startLoading, stopLoading, btnState) {
        onTap(startLoading, stopLoading, btnState);
      },
    );
  }
}
