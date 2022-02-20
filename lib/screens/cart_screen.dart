import 'package:flutter/material.dart';
import 'package:httprequest/services/api_services.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future ? cart;

  @override
  void initState() {
    // TODO: implement initState
    cart = ApiServices().getCartItems("2");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: cart,
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              List products = snapshot.data["products"];
              return ListView.builder(
                 itemExtent: 100.0,
                itemCount: products.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: ApiServices().getSingleProduct(products[index]["productId"]),
                        builder: (context, AsyncSnapshot asyncSnapshot){
                        if(asyncSnapshot.hasData){
                         return ListTile(
                           title: Text(asyncSnapshot.data["title"],style: TextStyle(fontWeight: FontWeight.bold,),),
                           subtitle: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 2),
                                      height: 25,
                                      width: 50,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(asyncSnapshot.data["rating"]["rate"].toString(),style: TextStyle(color: Colors.white),),
                                          Icon(Icons.star,color: Colors.white,size: 16,),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      ),
                                    ),
                                    Text(asyncSnapshot.data["rating"]["count"].toString()),
                                  ],
                                ),
                               ),
                               Container(
                                  child: Text("Qty: ${products[index]["quantity"].toString()}"),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(color: Colors.grey),
                          ),),
                             ],
                           ),
                           leading: Image.network(asyncSnapshot.data["image"]),
                           trailing: IconButton(
                             icon: Icon(Icons.delete,color: Colors.red,),
                             onPressed: () async {
                               await ApiServices().deleteCartItem(1);
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Deleted from cart"),));
                             },
                           ),
                         );
                        }
                        return LinearProgressIndicator();
                        });
                  }
                  );
            }
            if(snapshot.hasError){
              return Center(child: Text("Unable to Process your request, Please try after sometime"),);
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
