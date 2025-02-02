import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_v1/datas/cart_product.dart';
import 'package:loja_virtual_v1/datas/product_data.dart';
import 'package:loja_virtual_v1/models/cart_model.dart';
import 'package:loja_virtual_v1/models/user_model.dart';
import 'package:loja_virtual_v1/screens/cart_screen.dart';
import 'package:loja_virtual_v1/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;


  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  _ProductScreenState(this.product);
  String size;
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 8,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(height: 16),
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.5
                    ),
                    children: product.sizes.map((s){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                              color: s == size ? primaryColor : Colors.grey[500],
                              width: 3
                            )
                          ),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: size != null ?
                    (){
                      if(UserModel.of(context).isLoggedIn()){

                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = size;
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;
                        cartProduct.productData = product;

                        CartModel.of(context).addCartItem(cartProduct);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>CartScreen())
                        );
                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao Carrinho" :
                      "Entre para Comprar",
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
