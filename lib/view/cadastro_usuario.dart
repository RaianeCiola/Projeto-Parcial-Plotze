// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

// ignore: camel_case_types
class Cadastro_usuarioView extends StatefulWidget {
  const Cadastro_usuarioView({super.key});

  @override
  State<Cadastro_usuarioView> createState() => _cadastro_usuarioViewState();
}

class _cadastro_usuarioViewState extends State<Cadastro_usuarioView> {
//Chave para o formulário
  var formKey = GlobalKey<FormState>();
  var status = false;

  //COntroler  para os campos de textos
  var txtValor1 = TextEditingController();
  var txtValor2 = TextEditingController();
  var txtValor3 = TextEditingController();

  //
  // CAIXA DE DIÁLOGO
  //
  caixaDialogo(context, titulo, mensagem) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titulo),
        content: Text(
          mensagem,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Criar Nova Conta'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100, // Defina a cor de fundo aqui
        //ativar botão voltar
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //
              // Ícone
              //
              Icon(
                Icons.account_circle,
                size: 120,
                color: Colors.blueGrey.shade600,
              ),

              SizedBox(height: 20),

              //Nome
              TextFormField(
                controller: txtValor3,

                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),

                // Validação

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o Nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              //Email
              TextFormField(
                  controller: txtValor1,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  // Validação
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o Email';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Informe um Email válido!';
                    }
                    return null;
                  }),
              SizedBox(height: 20),

              //Senha
              TextFormField(
                controller: txtValor2,
                keyboardType: TextInputType.number,
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
              SizedBox(height: 20),

              //ElevatedButton
              ElevatedButton(
                // botão de login
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    //Validação com sucesso
                    Navigator.pushNamed(
                      context,
                      'menu',
                    );
                    caixaDialogo(context, 'User Adicionado',
                        'Usuário criado com sucesso!');
                  } else {
                    //Erro na Validação
                  }
                },
                //Estilo
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 60),
                  foregroundColor: Colors.grey.shade800,
                  backgroundColor: Colors.blueGrey.shade200,
                ),
                // Executar o processo de VALIDAÇÃO

                //Aparência
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),

              SizedBox(height: 30),
              ElevatedButton(
                // botão de login
                onPressed: () {
                    //Validação com sucesso
                    Navigator.pushNamed(
                      context,
                      'login',
                    );
                },
                //Estilo
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 60),
                  foregroundColor: Colors.grey.shade800,
                  backgroundColor: Colors.blueGrey.shade200,
                ),
                // Executar o processo de VALIDAÇÃO

                //Aparência
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
 
            ],
          ),
        ),
      ),
    );
  }
}
