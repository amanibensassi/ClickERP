import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:notification/constants.dart';

class TopMenu extends StatelessWidget {
  final String menu;
  final VoidCallback function;
  const TopMenu({required this.function, required this.menu, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 80,
          decoration: const BoxDecoration(
            color: kBlueColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: function,
                    child: const Text(
                      'back',
                      style: TextStyle(
                        fontSize: kBig,
                        color: Colors.white,
                      ),
                    ),
                    // child: SvgPicture.asset(
                    //   'images/back_arrow.svg',
                    // ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: kSpaceWidth,
                      ),
                      child: Text(
                        menu.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: kBig,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kSpacer,
            ),
          ]),
        ),
      ],
    );
  }
}
