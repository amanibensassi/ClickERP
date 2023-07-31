import 'package:flutter/material.dart';
import 'package:notification/constants.dart';

class BigButton extends StatelessWidget {
  final VoidCallback function;
  final String bigTitle;
  final double paddingValue;
  const BigButton({
    Key? key,
    required this.bigTitle,
    required this.paddingValue,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingValue),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.35,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              enableFeedback: false,
              shadowColor: Colors.transparent,
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: function,
            child: Text(
              bigTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 0.02,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
