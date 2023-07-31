import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/api/firebase_api.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/context_controller.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/webService/timer.dart';
import '../webService/login.dart';

CollectionReference tokenCollection =
    FirebaseFirestore.instance.collection('token');
List<Map<String, dynamic>> taskstab = [];

class AuthentificationController extends GetxController {
  // BuildContext context;
  final passwordController = TextEditingController();
  final loginController = TextEditingController();
  List<String> test = [];
  bool champsvide = false;
  String nom = '';
  String data = '';

  fInputControl() {
    BuildContext? cnx = ContextController.getContext();
    if (cnx != null) {
      if ((data != 'Failed') && (data != 'Network connexion failure')) {
        showDialog(
            context: cnx,
            builder: (cnx) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  title: champsvide
                      ? const Text(
                          'Champs vides !',
                          style: TextStyle(
                            color: kBlueColor,
                          ),
                        )
                      : const Text(
                          'Erreur de connexion!',
                          style: TextStyle(
                            color: kBlueColor,
                          ),
                        ),
                  content: champsvide
                      ? Text(
                          'Veuillez remplir vos champs par vos données adéquats.'
                              .tr,
                        )
                      : Text(
                          'Votre adresse mail ou mot de passe saisi sont erronés. Veuillez donner vos coordonnées valides.'
                              .tr,
                        ),
                  actions: [
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(cnx, false);
                        },
                        child: Text('Okey'.tr),
                      ),
                    ),
                  ],
                ));
      } else {
        if (data == 'Failed') {
          showDialog(
            context: cnx,
            builder: (cnx) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              title: const Text(
                'Erreur de connexion!',
                style: TextStyle(
                  color: kBlueColor,
                ),
              ),
              content: Text(
                'Le serveur a rencontré une erreur. Veuillez attendre quelques instants et réessayer ultérieurement.'
                    .tr,
              ),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(cnx, false);
                    },
                    child: Text('Okey'.tr),
                  ),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: cnx,
            builder: (cnx) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              title: const Text(
                'Problème de connexion !',
                style: TextStyle(
                  color: kBlueColor,
                ),
              ),
              content: Text(
                'L\'application n\'a pas pu se connecter à internet. Veuillez vérifier votre connexion.'
                    .tr,
              ),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(cnx, false);
                    },
                    child: Text('Okey'.tr),
                  ),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  fLoginAccount(TextEditingController cmail, TextEditingController cpwd) async {
    if (cmail.text == '' || cpwd.text == '') {
      champsvide = true;
      fInputControl();
    } else {
      test = await fetchData(cmail.text, cpwd.text);
      if (test.isEmpty) {
        fInputControl();
      } else if ((test.first == 'Failed') ||
          (test.first == 'Network connexion failure')) {
        data = test.first;
        fInputControl();
      } else {
        fSendToFirebase();
        FirebaseApi().tokeninitialize();
        MinuteTimer().startTimer();
        // MinuteTimer().secondtimer();
        TaskController().fgetAcceuil();
      }
    }
  }

  Future<bool> fgetdataUID(int userId) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('token');

    QuerySnapshot querySnapshot =
        await usersCollection.where('id', isEqualTo: userId).get();

    if (querySnapshot.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fgetdatatoken(String token, int id) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('token');

    QuerySnapshot querySnapshot = await usersCollection
        .where('tokenArray', arrayContainsAny: [token])
        .where('id', isEqualTo: id)
        .get();

    if (querySnapshot.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> fSendToFirebase() async {
    int iduser = await getFromSession('id');
    String token = await getFromSession('token');
    bool userid = await fgetdataUID(iduser);
    if (userid) {
      bool tokenid = await fgetdatatoken(token, iduser);
      if (tokenid) {
      } else {
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('token');
        QuerySnapshot querySnapshot =
            await usersCollection.where('id', isEqualTo: iduser).limit(1).get();

        if (querySnapshot.size > 0) {
          CollectionReference tokenCollection =
              FirebaseFirestore.instance.collection('token');
          QuerySnapshot querySnapshot = await tokenCollection
              .where('id', isEqualTo: iduser)
              .limit(1)
              .get();

          if (querySnapshot.size > 0) {
            DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
            dynamic tokenArray = documentSnapshot['tokenArray'];

            if (tokenArray is String) {
              tokenArray = [tokenArray]; // Convert to list
            }

            if (tokenArray is List<dynamic>) {
              tokenArray.add(token);

              await documentSnapshot.reference
                  .update({'tokenArray': tokenArray});
            } else {
              // print('Invalid tokenArray value');
              return;
            }
          }
        }
      }
    } else {
      await tokenCollection.add({
        'id': iduser,
        'tokenArray': token,
      });
    }
  }
}
