import 'package:flutter/material.dart';
import 'package:notification/constants.dart';

class InputPwd extends StatelessWidget {
  final double paddingValue;
  final String labelTextValue;
  final TextEditingController txController;

  const InputPwd({
    Key? key,
    required this.paddingValue,
    required this.labelTextValue,
    required this.txController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingValue),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: txController,
          obscureText: true,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            // errorText: loginController.wrongPw.value
            //     ? 'wrong password'.tr
            //     : loginController.filledPsw.value == false
            //         ? 'must be filled'.tr
            //         : null,
            hoverColor: Colors.white,
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(
              Icons.key, color: kGreyColor,
              //color: kPrimaryColor,
            ),
            // suffixIcon: IconButton(
            //   icon: loginController.togglePw.value
            //       ? const Icon(
            //           Icons.visibility_off,
            //           color: kGreyColor,
            //           //  color: kPrimaryColor,
            //         )
            //       : const Icon(
            //           Icons.visibility,
            //           color: kPrimaryColor,
            //         ),
            //   onPressed: () {
            //     loginController.fTogglePw();
            //   },
            // ),
            hintStyle: const TextStyle(
                //color: kPrimaryColor,
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
