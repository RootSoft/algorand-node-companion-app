import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:heroicons/heroicons.dart';

class InformationTile extends StatelessWidget {
  final String text;

  const InformationTile({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: HeroIcon(
          HeroIcons.informationCircle,
          color: const Color(0xFFF87E2C),
        ),
        contentPadding: EdgeInsets.all(8.0),
        title: Text(
          text,
          style: regularTextStyle,
        ),
      ),
    );
  }
}
