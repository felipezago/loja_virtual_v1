import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_v1/datas/product_data.dart';
import 'package:loja_virtual_v1/tiles/product_tile.dart';

class ProductScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ProductScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection("products")
                .document(snapshot.documentID)
                .collection("items")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.65),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {

                        ProductData data = ProductData.fromDocument(
                            snapshot.data.documents[index]);

                        data.category = this.snapshot.documentID;

                        return ProductTile("grid", data);
                      },
                      padding: EdgeInsets.all(4),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        ProductData data = ProductData.fromDocument(
                            snapshot.data.documents[index]);

                        data.category = this.snapshot.documentID;

                        return ProductTile("list", data);
                      },
                      padding: EdgeInsets.all(4),
                      itemCount: snapshot.data.documents.length,
                    )
                  ],
                );
              }
            },
          ),
        ));
  }
}
