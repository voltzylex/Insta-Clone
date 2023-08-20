import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  const FollowButton(
      {super.key,
      required this.borderColor,
      required this.buttonColor,
      required this.onFunction,
      required this.text,
      required this.textColor});
  final Function()? onFunction;
  final Color? buttonColor;
  final Color? borderColor;
  final String? text;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 28),
      child: TextButton(
        onPressed: onFunction,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(color: borderColor!),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: 250,
          height: 27,
          child: Text(
            text!,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
