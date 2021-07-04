import 'package:nodex_companion_app/themes/themes.dart';

class NodePropertyTile extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;

  const NodePropertyTile({
    required this.title,
    required this.value,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: mediumTextStyle.copyWith(
                color: Palette.primaryTextColor,
              ),
              maxLines: 1,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: mediumTextStyle.copyWith(
                color: color == null ? Palette.primaryTextColor : color,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
