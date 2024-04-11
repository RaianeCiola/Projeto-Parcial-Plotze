// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'view/login.dart';
import 'view/cadastro_usuario.dart';
import 'view/menu.dart';
import 'view/itens_lista.dart';
import 'model/lista_itens.dart';
import 'view/sobre_view.dart';



void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

//
// MainApp
//
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Itens_Lista> listaDeItens = Itens_Lista.gerarLista();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Organiza Tudo',
    //
    // ROTAS DE NAVEGÇÂO
    //
    initialRoute: 'login',
    routes:{
      'login' : (context) => LoginView(),
      'cadastro' : (context) => Cadastro_usuarioView(),
      'menu' : (context) => MenuView(),
      'itens' : (context) => Itens_ListaView( lista: listaDeItens),
      'sobre': (context) => SobreView(),
    }

    );
  }
}
