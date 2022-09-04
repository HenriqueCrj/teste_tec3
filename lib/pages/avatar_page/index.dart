import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

import 'package:teste_tec3/widgets/custom_appbar.dart';

import 'controller.dart';

class AvatarPage extends StatelessWidget {
  final avatarPageController = AvatarPageController();

  AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[600],
        appBar: CustomAppBar(
          avatarBorderColor: Colors.white,
          onAvatarPressed: () => Navigator.of(context).pop(),
          onSitePressed: () =>
              Navigator.of(context).pushReplacementNamed("/site_page"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FluttermojiCircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Salvar aparência: ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Tooltip(
                          message: "Salvar aparência",
                          // Esse widget salva o estado do avatar usando SharedPreferences internamente
                          // Eu também salvarei o estado no banco SQLite
                          child: FluttermojiSaveWidget(
                            radius: 30,
                            onTap: () {
                              avatarPageController.saveAvatar();
                              const snackBar = SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text('Novo avatar foi registrado'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: const Icon(Icons.save),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FluttermojiCustomizer(
                  scaffoldHeight:
                      min(300, MediaQuery.of(context).size.height * 0.7),
                  scaffoldWidth:
                      min(600, MediaQuery.of(context).size.width * 0.85),
                  autosave: false,
                  theme: FluttermojiThemeData(
                    primaryBgColor: Colors.grey,
                    secondaryBgColor: Colors.grey[600],
                    unselectedIconColor: Colors.grey[800],
                    iconColor: Colors.grey[800],
                    boxDecoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
