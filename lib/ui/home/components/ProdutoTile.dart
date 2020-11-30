import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_trabalho_final/controllers/manager/AppManager.dart';
import 'package:te_trabalho_final/objects/produto.dart';
import 'package:te_trabalho_final/ui/_utils/progressDialog.dart';
import 'package:te_trabalho_final/ui/home/components/NewProduct.dart';

class ProdutoTile extends StatelessWidget {
  final Produto produto;

  const ProdutoTile(this.produto);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(debugLabel: produto.id.toString()),
      onDismissed: (a) async {
        progressDialog(context);
        await context.read<AppManager>().deleteProduto(produto.id);
        Navigator.pop(context);
      },
      child: InkWell(
        onTap: () => showDialog(context: context, builder: (_) => NewProduct(produto: produto)),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.transparent,
                  child: Image.network(produto.foto, fit: BoxFit.contain),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produto.nome,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Valor Unitário: R\$ ${produto.valor.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "Quantidade ${produto.quant}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "Total R\$ ${produto.valoTotal.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Checkbox(
                  value: produto.check,
                  onChanged: (a) async {
                    progressDialog(context);
                    await context.read<AppManager>().changeProdutoState(produto.id, a);
                    Navigator.pop(context);

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
