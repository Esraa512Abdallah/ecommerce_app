import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Alignment alignment;
  final double fontsize;
  final String text;
  final Function onPressed;
  final Widget child;

  final Color? borderColor;

  CustomButton({
    required this.color,
    this.alignment = Alignment.center,
    this.fontsize = 18,
    this.text = ' ',
    this.borderColor,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Container(
          width: MediaQuery.of(context).size.width,
        child: FlatButton(
          onPressed: () {
            onPressed();
          },
          color: color,
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(
              width: 1.0,
              color: (borderColor != null) ? Colors.teal : Colors.transparent,
            ),
          ),
          child: child,
        ),
    ));
  }
}
