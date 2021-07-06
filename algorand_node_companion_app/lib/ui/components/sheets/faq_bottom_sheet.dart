import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/spacing/spacing.dart';

class FAQBottomSheet extends StatelessWidget {
  final String question;
  final String answer;

  FAQBottomSheet({
    required this.question,
    required this.answer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        padding: EdgeInsets.all(paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            VerticalSpacing(of: 18.0),
            Text(
              question,
              style: semiBoldTextStyle,
            ),
            VerticalSpacing(of: paddingSizeDefault),
            Text(
              answer,
              style: mediumTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
