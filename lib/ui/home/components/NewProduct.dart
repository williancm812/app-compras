import 'package:flutter/material.dart';
import 'package:te_trabalho_final/controllers/manager/AppManager.dart';
import 'package:te_trabalho_final/objects/produto.dart';
import 'package:provider/provider.dart';
import 'package:te_trabalho_final/ui/_utils/progressDialog.dart';

class NewProduct extends StatefulWidget {
  final Produto produto;

  const NewProduct({this.produto});

  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  Produto produto = Produto.clean();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.produto != null) produto = widget.produto;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  widget.produto != null
                      ? CircleAvatar(
                          maxRadius: 80,
                          backgroundColor: Colors.transparent,
                          child: Image.network(produto.foto, fit: BoxFit.contain),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 10),
                  Text(
                    widget.produto == null ? "Novo Produto" : "Editar Produto",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                  ),
                  Divider(),
                  TextFormField(
                    initialValue: produto.nome,
                    onSaved: (value) {
                      if (value.isEmpty) value = 'Sem nome';
                      produto.nome = value;
                    },
                    decoration: InputDecoration(labelText: "Descrição do Produto"),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    initialValue: produto.valor?.toStringAsFixed(2) ?? '',
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if (value.isEmpty) value = '1';
                      produto.valor = double.parse(value);
                    },
                    decoration: InputDecoration(labelText: "Valor Unitário do Produto"),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    initialValue: produto.quant?.toStringAsFixed(2) ?? '',
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if (value.isEmpty) value = '1';
                      produto.quant = double.parse(value);
                    },
                    decoration: InputDecoration(labelText: "Quantidade de Compra"),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    initialValue: produto.foto,
                    decoration: InputDecoration(labelText: "Url da imagem (opcional)"),
                    onSaved: (value) {
                      if (value.isEmpty)
                        value =
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXB4H7zcUL8kHWZseJueSBsiOAAPGJK63-kQ&usqp=CAU';
                      produto.foto = value;
                    },
                  ),
                  const SizedBox(height: 18),
                  RaisedButton(
                    onPressed: () async {
                      progressDialog(context);
                      formKey.currentState.save();
                      widget.produto == null
                          ? await context.read<AppManager>().createProduto(produto)
                          : await context.read<AppManager>().updateProduto(produto);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    color: Color(0xFF3366FF),
                    textColor: Colors.white,
                    child: Text("Salvar" + (widget.produto == null ? '' : " alterações")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
