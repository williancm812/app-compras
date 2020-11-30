import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:te_trabalho_final/controllers/ws/WebServiceController.dart';
import 'package:te_trabalho_final/objects/produto.dart';
import 'package:te_trabalho_final/objects/usuario.dart';

class AppManager extends ChangeNotifier {
  Usuario usuario;

  int get produtosRestantes => produtos.count((e) => e.check == false);

  int get produtosConcluidos => produtos.count((e) => e.check);

  double get valorTotal => produtos.sumByDouble((e) => e.valor * e.quant);

  List<Produto> produtos = [];
  List<Produto> searchProdutos = [];
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _search;

  String get search => _search;

  set search(String value) {
    _search = value;
    if (value == null)
      searchProdutos = produtos;
    else
      searchProdutos = produtos.where((element) => element.nome.toLowerCase().contains(value.toLowerCase())).toList();
    notifyListeners();
  }

  Future<void> changeProdutoState(int id, bool newState) async {
    produtos.firstWhere((element) => element.id == id).check = newState;
    await updateProduto(produtos.firstWhere((element) => element.id == id));
    notifyListeners();
  }

  Future<bool> validUser(String email, String senha) async {
    try {
      Map<String, dynamic> result = await WebServiceController().executeGetDb(query: "/usuarios");

      if (result != null) {
        if (!result.containsKey("error") && !result.containsKey("connection")) {
          List maps = result["usuarios"] as List;

          print(email);
          print(senha);
          Map<String, dynamic> test = maps.firstWhere((e) {
            return e['email'] == email && e['senha'].toString() == senha;
          }, orElse: () => null);
          print(test);
          if (test == null) throw Exception('Usuario não encontrado!');

          usuario = Usuario.fromMap(test);
          return true;
        }
      }
      throw Exception('Retorno vazio!');
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getProdutos() async {
    try {
      Map<String, dynamic> result = await WebServiceController().executeGetDb(query: "/produtos");

      if (result != null) {
        if (!result.containsKey("error") && !result.containsKey("connection")) {
          List<Produto> auxProdutos = [];
          List maps = result["produtos"] as List;
          maps.forEach((element) => auxProdutos.add(Produto.fromMap(element)));
          auxProdutos.forEach((element) {
            print(element);
          });
          produtos = auxProdutos.where((element) => element.usuario == usuario.id).toList();
          produtos.forEach((element) {
            print(element);
          });
          notifyListeners();
          return true;
        }
      }
      throw Exception('Retorno vazio!');
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> createProduto(Produto produto) async {
    try {
      produto.usuario = usuario.id;

      Map<String, dynamic> body = {'produto': produto.toMap()};
      Map<String, dynamic> result = await WebServiceController().executePostDb(
        query: "/produtos",
        body: body,
      );
      print(result);
      if (result != null) {
        if (!result.containsKey("error") && !result.containsKey("connection")) {
          await getProdutos();
          return true;
        }
      }
      throw Exception('Retorno vazio!');
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateProduto(Produto produto) async {
    try {
      Map<String, dynamic> body = {'produto': produto.toMap()};
      Map<String, dynamic> result = await WebServiceController().executePutDb(
        query: "/produtos/${produto.id}",
        body: body,
      );
      print(result);
      if (result != null) {
        if (!result.containsKey("error") && !result.containsKey("connection")) {
          produtos.firstWhere((element) => element.id == produto.id).update(produto);
          notifyListeners();
          return true;
        }
      }
      throw Exception('Retorno vazio!');
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> deleteProduto(int id) async {
    try {
      Map<String, dynamic> result = await WebServiceController().executeDeleteDb(query: "/produtos/$id");
      print(result);
      if (result != null) {
        if (!result.containsKey("error") && !result.containsKey("connection")) {
          produtos.removeWhere((element) => element.id == id);
          notifyListeners();
          return true;
        }
      }
      throw Exception('Retorno vazio!');
    } catch (e) {
      print(e);
      return false;
    }
  }
}
