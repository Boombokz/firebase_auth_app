import 'package:auth_app_with_firebase/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  CircleButton(
      {required this.title, required this.onPressed, required this.isLoading});

  final String title;
  final Function onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        alignment: Alignment.center,
        child: !isLoading
            ? Text(
                title,
                textAlign: TextAlign.center,
                style: button,
              )
            : SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)),
      ),
    );
  }
}
