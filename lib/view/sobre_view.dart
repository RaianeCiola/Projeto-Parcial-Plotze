import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => SobreView(), // Remova 'const' aqui
  ));
}

class SobreView extends StatelessWidget {
  const SobreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Sobre o Projeto',
              style: TextStyle(fontWeight: FontWeight.bold,
               fontSize: 26),
            ),
            centerTitle: true),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Image.asset(
                'lib/imagens/logo.png',
                width: 200,
                height: 200,
              ),

              // SizedBox(height: 30),
              // ignore: prefer_const_constructors
              Text(
                '\nTema: Organização '
                '\n\nObejetivo: Organiza Tudo foi desenvolvido pensando em proporcionar ao usuario'
                ' um aplicativo de organização versatil sem tema específico onde ele pode gerenciar suas tarefas'
                ' e demandas no formato de listas e itens. '
                '\n\n Desenvolvedora: Raiane dos Santos Ciola - 835567',
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
