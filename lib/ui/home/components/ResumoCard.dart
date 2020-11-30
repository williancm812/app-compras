import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_trabalho_final/controllers/manager/AppManager.dart';

class ResumoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.lightGreen,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Consumer<AppManager>(builder: (_, manager, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Resumo da Lista",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                Divider(color: Colors.white, height: 0.1),
                line("Total estimado", "R\$   ${manager.valorTotal.toStringAsFixed(2)}"),
                line("Itens Coletados", "${manager.produtosConcluidos}"),
                line("Itens Restantes", "${manager.produtosRestantes}"),
              ]
                  .map((e) => Column(
                        children: [e, const SizedBox(height: 12)],
                      ))
                  .toList(),
            );
          }
        ),
      ),
    );
  }

  Widget line(String text, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
