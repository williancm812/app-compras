import 'package:flutter/material.dart';
import 'package:te_trabalho_final/objects/produto.dart';
import 'package:te_trabalho_final/ui/home/components/ProdutoTile.dart';

class ProdutosList extends StatelessWidget {
  final String title;
  final List<Produto> produtos;

  const ProdutosList({@required this.title, @required this.produtos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Divider(),
        produtos.length == 0
            ? Text(
                'Sem produtos no momento...',
                style: TextStyle(color: Colors.red),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < produtos.length; i++) ProdutoTile(produtos[i]),
                ],
              )
      ],
    );
  }
}
