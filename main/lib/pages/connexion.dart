import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/context_controller.dart';
import 'package:notification/widgets/big_button.dart';
import '../widgets/custom_bar.dart';
import '../controllers/authentification_controller.dart';
import '../widgets/input_mail.dart';
import '../widgets/input_pwd.dart';

class Connexion extends StatelessWidget {
  const Connexion({super.key});

  @override
  Widget build(BuildContext context) {
    ContextController.setContext(context);

    final cmail = TextEditingController();
    final cpwd = TextEditingController();
    return MediaQuery.of(context).size.width < kScreenSize
        ? GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: kIsWeb
                  ? null
                  : const CustomBar(
                      light: true,
                    ),
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 180),
                        child: InputEmailLogin(
                          labelTextValue: 'Email',
                          paddingValue: 35,
                          txController: cmail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: InputPwd(
                            paddingValue: 35,
                            labelTextValue: "Mot de passe",
                            txController: cpwd),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.35,
                            height: 60,
                            child: BigButton(
                              bigTitle: 'connexion',
                              paddingValue: 0,
                              function: () {
                                AuthentificationController()
                                    .fLoginAccount(cmail, cpwd);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          )
        : const Scaffold(
            body: Text("erreur"),
          );
  }
}
