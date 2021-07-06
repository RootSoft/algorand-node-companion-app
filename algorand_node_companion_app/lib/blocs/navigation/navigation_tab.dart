import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:equatable/equatable.dart';

class NavigationTab extends Equatable {
  final String label;
  final Widget icon;

  NavigationTab({
    required this.label,
    required this.icon,
  });

  @override
  List<Object?> get props => [label, icon];
}
