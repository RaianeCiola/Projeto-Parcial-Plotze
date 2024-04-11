// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
//automaticallyImplyLeading: false,

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //Chave para o formulário
  var formKey = GlobalKey<FormState>();
  var status = false;

  //COntroler  para os campos de textos
  var txtValor1 = TextEditingController();
  var txtValor2 = TextEditingController();

  //
  // CAIXA DE DIÁLOGO
  //
  caixaDialogo(context, titulo, mensagem) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancelar'),
            child: Text('cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: Text('ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Defina a cor de fundo aqui
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
        //barra de rolagem
        child: SingleChildScrollView(
          //Direção da barra de rolagem
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(
                  'lib/imagens/logo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 30),

              
                TextFormField(
                    controller: txtValor1,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o Email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Informe um Email válido!\nEX: exemplo@exemplo.com';
                      }
                      return null;
                    }),
                SizedBox(height: 30),
                TextFormField(
                  controller: txtValor2,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                     prefixIcon: Icon(Icons.password),
                  ),

                  //
                  // Validação
                  //
                  validator: (value) {
                    if (value == null) {
                      return 'Informe a senha';
                    } else if (value.isEmpty) {
                      return 'Informe a Senha';
                    } else if (double.tryParse(value) == null) {
                      return 'Informe uma SENHA NUMÉRICA';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),

//----------------------BOTÕES-------------------------//
                //ElevatedButton

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    // botão de login
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushNamed(
                          context,
                          'menu',
                          
                        );
                      } else {
                        //Erro na Validação
                      }
                    },
                    //Estilo
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey.shade800,
                      backgroundColor: Colors.blueGrey.shade200,
                    ),
                    //Aparência
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

// botão de cadastrar usuário
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'cadastro');
                    },
                    //Estilo
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey.shade800,
                      backgroundColor: Colors.blueGrey.shade200,
                    ),
                    //Aparência
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

// botão Sobre

                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'sobre');
                    },
                    //Estilo
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blueGrey.shade700,
                    ),
                    //Aparência
                    child: Text(
                      'Sobre o Desenvolvedor',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
