import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget(
      {super.key,
      required this.onPressed,
      required this.logoPath,
      required this.authText});

  final Function() onPressed;
  final String logoPath;
  final String authText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffFFFFE0),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Image.asset(logoPath),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            authText,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
