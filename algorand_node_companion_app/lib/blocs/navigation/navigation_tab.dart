import 'package:equatable/equatable.dart';
import 'package:nodex_companion_app/themes/themes.dart';

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
