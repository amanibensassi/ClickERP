import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class CustomBar extends StatelessWidget implements PreferredSizeWidget {
  final bool light;
  const CustomBar({
    required this.light,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: light ? Colors.black : kBlueColor,
      systemOverlayStyle: Platform.isIOS
          ? light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light
          : SystemUiOverlayStyle(
              statusBarColor: light ? Colors.white : kBlueColor,
              statusBarIconBrightness:
                  light ? Brightness.dark : Brightness.light,
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
