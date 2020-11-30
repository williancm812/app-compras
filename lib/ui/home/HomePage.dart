import 'package:flutter/material.dart';
import 'package:te_trabalho_final/controllers/manager/AppManager.dart';
import 'package:te_trabalho_final/ui/home/components/NewProduct.dart';
import 'package:te_trabalho_final/ui/home/components/ProdutosList.dart';
import 'package:te_trabalho_final/ui/home/components/ResumoCard.dart';
import 'package:provider/provider.dart';
import 'package:te_trabalho_final/ui/login/LoginPage.dart';

import 'dialogs/search_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo, ${context.watch<AppManager>().usuario.nome}"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.open_in_new_rounded),
            onPressed: () {
              context.read<AppManager>().usuario = null;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
          ),
        ],
      ),
      body: Consumer<AppManager>(builder: (_, manager, __) {
        return RefreshIndicator(
          onRefresh: () async {
            await manager.getProdutos();
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            children: [
              ResumoCard(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Produtos no Carinho",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      manager.search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(
                          initialtext: manager.search,
                        ),
                      );
                    },
                  ),
                ],
              ),
              manager.search != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pesquisando por '${manager.search}'"),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            manager.search = null;
                          },
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              Divider(),
              ProdutosList(
                title: "Produtos Restantes",
                produtos: manager.searchProdutos.where((element) => !element.check).toList(),
              ),
              const SizedBox(height: 20),
              ProdutosList(
                title: "Produtos Concluídos",
                produtos: manager.searchProdutos.where((element) => element.check).toList(),
              ),
              const SizedBox(height: 80),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => NewProduct());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
