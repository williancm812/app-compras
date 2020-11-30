import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_trabalho_final/controllers/manager/AppManager.dart';
import 'package:te_trabalho_final/ui/login/LoginPage.dart';

import 'ui/home/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppManager>(
          create: (_) => AppManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Compras App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}
