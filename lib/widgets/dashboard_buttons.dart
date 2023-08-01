import 'package:flutter/material.dart';
import 'package:notification/constants.dart';

class DashbordButtons extends StatelessWidget {
  final VoidCallback function;
  final String bigTitle;
  final String nb;
  const DashbordButtons({
    Key? key,
    required this.bigTitle,
    required this.nb,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.3,
      height: 170,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
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
              const SizedBox(
                height: 150 / 1.9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    nb,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 0.02,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
