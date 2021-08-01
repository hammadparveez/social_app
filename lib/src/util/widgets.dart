import 'package:social_app/src/export.dart';

void showAlertDialog(BuildContext context, Widget content) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              content,
            ],
          )));
}
