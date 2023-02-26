import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'models/models.dart';
import 'navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appStateManager = AppStateManager();
  await appStateManager.initializeApp();
  runApp(RamanHome(appStateManager: appStateManager));
}

// class ExampleApplication extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: SettingPage());
//   }
// }

class RamanHome extends StatefulWidget {
  final AppStateManager appStateManager;

  const RamanHome({
    super.key,
    required this.appStateManager,
  });

  @override
  RamanHomeState createState() => RamanHomeState();
}

class RamanHomeState extends State<RamanHome> {
  late final _groceryManager = GroceryManager();
  late final _profileManager = ProfileManager();
  late final _appRouter = AppRouter(
    widget.appStateManager,
    _profileManager,
    _groceryManager,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(
          create: (context) => widget.appStateManager,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = RamanAppTheme.dark();
          } else {
            theme = RamanAppTheme.light();
          }

          final router = _appRouter.router;

          return MaterialApp.router(
            theme: theme,
            title: '食源性致病菌检测',
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
          );
        },
      ),
    );
  }
}

