import 'package:flutter/material.dart';
import 'package:loja_virtual_v1/models/user_model.dart';
import 'package:loja_virtual_v1/screens/login_screen.dart';
import 'package:loja_virtual_v1/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16,8),
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                        child: Text("Loja Virtual \nV1",
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        top: 8,
                        left: 0,
                    ),
                    Positioned(
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Text(!model.isLoggedIn() ? "Entre ou Cadastre-se >" : "Sair",
                                  style: TextStyle(color: Theme.of(context).primaryColor,
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                onTap: (){
                                  if(!model.isLoggedIn())
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>LoginScreen())
                                    );
                                  else
                                    model.signOut();
                                },
                              )
                            ]
                          );

                        },
                      ),
                      bottom: 0,
                      left: 0,
                    )

                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
