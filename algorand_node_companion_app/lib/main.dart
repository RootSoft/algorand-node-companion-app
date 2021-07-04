import 'package:nodex_companion_app/themes/themes.dart';

void main() async {
  // Initialize hive
  await Hive.initFlutter();

  // if (Platform.isWindows || Platform.isMacOS) {
  //   setWindowTitle('Algorand Node Monitor');
  //   await DesktopWindow.setWindowSize(Size(1000, 700));
  //   setWindowMinSize(const Size(800, 500));
  //   setWindowMaxSize(Size.infinite);
  // }

  // Register the service locator and dependencies
  await ServiceLocator.register();

  // Register the routing
  await RouteConfiguration.register();

  final routeName = '/'; //MainScreen.routeName;

  // Run the app
  runApp(TemplateApp(initialRoute: routeName));
}

class TemplateApp extends StatelessWidget {
  final String initialRoute;

  TemplateApp({
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Algorand Node Companion App',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initialRoute,
      onGenerateRoute: router.generator,
    );
  }
}
