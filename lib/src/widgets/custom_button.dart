import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReuseButton extends StatelessWidget {
  String button_name;
  Function() buttonaction;

  ReuseButton({
    super.key,
    required this.button_name,
    required this.buttonaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final font = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.94,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(
            255,
            64,
            122,
            148,
          )),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () {
      
          buttonaction();
        },
        child: Text(
          button_name,
          style: font.labelLarge?.copyWith(color: theme.colorScheme.onPrimary),
        ),
      ),
    );
  }
}
