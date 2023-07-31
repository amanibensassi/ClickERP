import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
// import '../controllers/authentification_controller.dart';

class InputEmailLogin extends StatelessWidget {
  final double paddingValue;
  final String labelTextValue;
  final TextEditingController txController;

  const InputEmailLogin({
    Key? key,
    required this.paddingValue,
    required this.labelTextValue,
    required this.txController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final loginController = AuthentificationController().loginController;
    return Padding(
      padding: EdgeInsets.only(top: paddingValue),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: txController,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hoverColor: Colors.white,
            prefixIcon: const Icon(
              Icons.mail, color: kGreyColor,
              //  color: kPrimaryColor,
            ),
            fillColor: Colors.white,
            filled: true,
            hintStyle: const TextStyle(
                //  color: kPrimaryColor,
                ),
            focusColor: kPrimaryColor,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: labelTextValue,
          ),
        ),
      ),
    );
  }
}
