import 'package:social_app/src/export.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        builder: () => GetMaterialApp(
          title: Strings.appTitle,
          onGenerateRoute: Routes.onGenerateRoute,
        ),
      ),
    );
  }
}
