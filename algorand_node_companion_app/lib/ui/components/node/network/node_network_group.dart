import 'package:algorand_node_companion_app/shared/shared.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';

class NodeNetworkGroup extends StatefulWidget {
  final NodeNetwork network;
  final ValueChanged<NodeNetwork> onChanged;

  const NodeNetworkGroup({
    required this.network,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _NodeNetworkGroupState createState() => _NodeNetworkGroupState();
}

class _NodeNetworkGroupState extends State<NodeNetworkGroup> {
  NodeNetwork? _network = NodeNetwork.MAINNET;

  @override
  void initState() {
    super.initState();
    _network = widget.network;
  }

  @override
  void didUpdateWidget(covariant NodeNetworkGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    _network = widget.network;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 3,
      physics: NeverScrollableScrollPhysics(),
      children: NodeNetwork.values
          .map(
            (network) => Center(
              child: RadioListTile<NodeNetwork>(
                title: Text(network.name),
                value: network,
                groupValue: _network,
                onChanged: (NodeNetwork? network) {
                  if (network == null) return;

                  setState(() {
                    _network = network;
                  });

                  widget.onChanged(network);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
