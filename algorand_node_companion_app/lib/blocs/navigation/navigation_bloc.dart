import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/blocs/navigation/navigation.dart';

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
