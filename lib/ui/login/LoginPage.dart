import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_trabalho_final/controllers/manager/AppManager.dart';
import 'package:te_trabalho_final/ui/_utils/showSnackBar.dart';
import 'package:te_trabalho_final/ui/home/HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController()..text = 'willianmatheuscm@gmail.com';
  final TextEditingController passController = TextEditingController()..text = '123456';

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF3366FF),
                const Color(0xFF5599FF),
                const Color(0xFF00BBFF),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: scaffoldKey,
          body: Center(
            child: Consumer<AppManager>(builder: (_, manager, child) {
              return Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(40.0),
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Olá.",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Bem vindo ao aplicativo de Compras",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text("USERNAME", style: TextStyle(color: Colors.white, fontSize: 16)),
                    TextFormField(
                      controller: emailController,
                      enabled: !manager.loading,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                          errorStyle: TextStyle(color: Colors.orange, fontSize: 16)),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        // if (!Utility.emailValid(email.trim())) {
                        //   return 'E-mail inválido';
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text("PASSWORD", style: TextStyle(color: Colors.white, fontSize: 16)),
                    TextFormField(
                      controller: passController,
                      enabled: !manager.loading,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: manager.loading ? null : () => setState(() => obscureText = !obscureText),
                            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                          focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                          errorStyle: TextStyle(color: Colors.orange, fontSize: 16)),
                      autocorrect: false,
                      obscureText: obscureText,
                      validator: (pass) {
                        if (pass.trim().isEmpty || pass.trim().length < 6) {
                          return 'Senha inválida';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(4, 15),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(12),
                                topRight: const Radius.circular(12),
                              ),
                            ),
                            height: 45,
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: manager.loading
                                  ? null
                                  : () async {
                                      if (formKey.currentState.validate()) {
                                        manager.loading = true;
                                        if (await manager.validUser(emailController.text, passController.text)) {
                                          await manager.getProdutos();
                                          manager.loading = false;
                                          Navigator.pushReplacement(
                                              context, MaterialPageRoute(builder: (_) => HomePage()));
                                        } else {
                                          manager.loading = false;
                                          showSnackBar(
                                            scaffoldKey: scaffoldKey,
                                            text: "Error ao realizar o login",
                                            color: Colors.red,
                                          );
                                        }
                                      }
                                    },
                              child: manager.loading
                                  ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                                  : Center(child: Text("LOGIN")),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
