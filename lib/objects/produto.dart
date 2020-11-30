import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class Produto {
  int id;
  int usuario;
  String nome;
  String foto;
  bool check;
  double valor;
  double quant;

  double get valoTotal => valor * quant;

  Produto({
    @required this.id,
    @required this.nome,
    @required this.foto,
    @required this.check,
    @required this.valor,
    @required this.usuario,
    @required this.quant,
  });

  @override
  String toString() {
    return 'Produto{id: $id, usuario: $usuario, nome: $nome, foto: $foto, check: $check, valor: $valor, quant: $quant}';
  }

  Produto.clean() {
    this.id = -1;
    this.nome = '';
    this.quant = null;
    this.valor = null;
    this.usuario = null;
    this.check = false;
    this.foto = '';
  }

  factory Produto.fromMap(Map<String, dynamic> json) => Produto(
        id: json['id'],
        nome: json['nome'],
        foto: json['foto'],
        check: json['pego'] == 1,
        valor: json['valorUn'].toString().toDouble(),
        usuario: json['usuario'],
        quant: json['quantidade'].toString().toDouble(),
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'foto': foto,
      'pego': check ? 1 : 0,
      'valorUn': valor,
      'usuario': usuario,
      'quantidade': quant,
    };
  }

  void update(Produto produto) {
    this.id = produto.id;
    this.nome = produto.nome;
    this.quant = produto.quant;
    this.valor = produto.valor;
    this.usuario = produto.usuario;
    this.check = produto.check;
    this.foto = produto.foto;
  }
}
