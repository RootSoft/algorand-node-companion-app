import 'package:nodex_companion_app/routes/routes.dart';
import 'package:nodex_companion_app/ui/screens/screens.dart';

final router = FluroRouter();

class RouteConfiguration {
  static Future<void> register() async {
    // Register the routes
    router.define("/", handler: rootHandler);
    router.define(WelcomeScreen.routeName, handler: welcomeHandler);
    router.define(NodeFormScreen.routeName, handler: nodeFormHandler);
    router.define(ParticipationScreen.routeName, handler: consensusHandler);
    router.define(ImportAccountScreen.routeName, handler: importAccountHandler);
  }
}
