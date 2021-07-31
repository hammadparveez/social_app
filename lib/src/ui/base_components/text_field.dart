import 'package:social_app/src/export.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;

  const CustomTextField(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.validator,
      this.hintText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
