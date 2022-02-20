import 'package:flutter/material.dart';
import 'package:httprequest/models/product_model.dart';
import 'package:httprequest/screens/all_category.dart';
import 'package:httprequest/screens/cart_screen.dart';
import 'package:httprequest/screens/fruits_screen.dart';
import 'package:httprequest/screens/single_product.dart';
import 'package:httprequest/services/api_services.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  Future ? products;
  @override
  void initState() {
    // TODO: implement initState
    products = ApiServices().getAllProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
              icon: Icon(Icons.tune),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AllCategory()));},),
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));},),
          IconButton(
            icon: Image.asset('assets/images/fruit.png',height: 22,width: 22,color: Colors.white,),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => FruitsScreen()));},),
        ],
      ),

      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: products,
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
               return Center(
                 child: GridView.builder(
                     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                         maxCrossAxisExtent: 200,
                         childAspectRatio: 2 / 3,
                         crossAxisSpacing: 20,
                         mainAxisSpacing: 20),
                     itemCount: snapshot.data.length,
                     itemBuilder: (BuildContext ctx, index) {
                       Product product = snapshot.data[index];
                       return GestureDetector(
                         child: Hero(
                           tag: product.id,
                           child: Card(
                             child: Container(
                               padding: EdgeInsets.all(5.0),
                               child: Column(
                                 children: [
                                   Image.network(product.image,height: 180,width: 180,),
                                   Text(product.title,textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                   Text("\$: ${product.price}")
                                 ],
                               ),
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(15)),
                             ),
                           ),
                         ),
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => SingleProduct(product.id)));
                         },
                       );
                     }),
               );
              }
            else if(snapshot.hasError){
              return Center(child: Text("Unable to Process your request, Please try after sometime"),);
            }
              return const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}

