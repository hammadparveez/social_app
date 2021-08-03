import 'package:social_app/di/service_locator.dart';
import 'package:social_app/src/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  await Firebase.initializeApp();
  runApp(App());
}
