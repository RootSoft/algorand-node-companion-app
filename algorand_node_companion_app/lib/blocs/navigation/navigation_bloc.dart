import 'package:algorand_node_companion_app/blocs/navigation/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationTab> {
  NavigationBloc(NavigationTab tab) : super(tab);

  void changeTab(NavigationTab tab) {
    add(NavigationTabChanged(tab: tab));
  }

  @override
  Stream<NavigationTab> mapEventToState(NavigationEvent event) async* {
    if (event is NavigationTabChanged) {
      yield event.tab;
    }
  }

  NavigationTab get currentTab => state;
}
