import 'package:flutter/material.dart';
import 'package:loja_virtual_v1/models/cart_model.dart';
import 'package:loja_virtual_v1/models/user_model.dart';
import 'package:loja_virtual_v1/screens/home_screen.dart';
import 'package:loja_virtual_v1/screens/login_screen.dart';
import 'package:loja_virtual_v1/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child:  MaterialApp(
                title: 'Felipe Store',
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: Color.fromARGB(255, 4, 125, 141)
                ),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              ),
            );
          },
        )
    );

  }
}

