import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final double? margin;
  final String buttonTitle;
  final Function()? onButtonPressed;
  final double fontSize;
  final Color color, buttonTextColor;
  final EdgeInsetsGeometry buttonPadding;
  final RoundedRectangleBorder shape;
  final double? width;
  final double? height;

  const RoundedButtonWidget({
    Key? key,
    this.margin = 0.02,
    required this.buttonTitle,
    required this.onButtonPressed,
    required this.color,
    required this.buttonTextColor,
    required this.fontSize,
    required this.buttonPadding,
    required this.shape,
    required this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: size.width * margin!),
      width: width,
      child: MaterialButton(
        elevation: 0,
        shape: shape,
        padding: buttonPadding,
        color: color,
        disabledColor: color,
        onPressed: onButtonPressed,
        child: Text(
          buttonTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Gilroy-Bold',
            color: buttonTextColor,
            fontSize: fontSize,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    );
  }
}