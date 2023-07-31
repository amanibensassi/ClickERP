import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/constants.dart';
import 'package:notification/widgets/big_button.dart';
import 'package:notification/widgets/top_menu.dart';
import 'package:notification/controllers/context_controller.dart';

import '../widgets/custom_bar.dart';

class Page404 extends StatelessWidget {
  // Declare taskList as nullable

  const Page404({
    Key? key,
  }) : super(key: key);

  static const route = '/404Page';

  @override
  Widget build(BuildContext context) {
    ContextController.setContext(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const CustomBar(light: false),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopMenu(function: () {}, menu: ''),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Center(
                      child: Text(
                        "Pas d'internet",
                        style: TextStyle(color: kBlueColor, fontSize: 30),
                      ),
                    ),
                    const Text(
                      "Veuillez vérifier votre connexion internet et rafraîchir l'application. Assurez-vous d'avoir une connexion internet active et stable. ",
                      style: TextStyle(color: kBlueColor, fontSize: 20),
                    ),
                    BigButton(
                        bigTitle: 'retour',
                        paddingValue: 50,
                        function: () {
                          Get.back();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
