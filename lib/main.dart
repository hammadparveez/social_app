import 'package:social_app/src/export.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Social Media',
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
