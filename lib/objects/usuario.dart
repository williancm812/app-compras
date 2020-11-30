import 'package:flutter/material.dart';

class Usuario {
  int id;
  String email;
  String senha;
  String nome;

  Usuario({
    @required this.id,
    @required this.email,
    @required this.senha,
    @required this.nome,
  });

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        email: json['email'],
        senha: json['senha'].toString(),
        nome: json['nome'],
      );
}
