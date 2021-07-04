import 'package:equatable/equatable.dart';
import 'package:nodex_companion_app/blocs/navigation/navigation.dart';

abstract class NavigationEvent extends Equatable {}

class NavigationTabChanged extends NavigationEvent {
  final NavigationTab tab;

  NavigationTabChanged({required this.tab});

  @override
  List<Object?> get props => [tab];
}
