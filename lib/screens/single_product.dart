import 'package:flutter/material.dart';
import 'package:httprequest/services/api_services.dart';

class SingleProduct extends StatefulWidget {
final id;
SingleProduct(this.id);
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  Future ? product;
  @override
  void initState() {
    // TODO: implement initState
    product = ApiServices().getSingleProduct(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: FutureBuilder(
        future: product,
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.transparent,
                      child: Center(
                        child: Image.network(snapshot.data["image"],height: 200,width: 200,),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Card(
                        color: Colors.white,
                        elevation: 20.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                          child: Text(snapshot.data["title"],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                                      SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(" \$ ${snapshot.data["price"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                          Row(
                                            children: [
                                              Text(snapshot.data["rating"]["rate"].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                              Icon(Icons.star,color: Colors.yellow,size: 20,),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Chip(label: Text(snapshot.data["category"],style: TextStyle(fontSize: 15, color: Colors.white),),backgroundColor: Colors.blueGrey,),
                                      SizedBox(height: 5,),
                                      Text(snapshot.data["description"],textAlign: TextAlign.justify,style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.black,
                                      ),
                                      height: 50,
                                      width: 130,
                                      //color: Colors.black,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.add_shopping_cart,color: Colors.white,),
                                          Text("Add to cart",style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                  ),
                                onTap: () async {
                                  await ApiServices().updateCart(1, widget.id);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product added to cart"),));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text("Unable to Process your request, Please try after sometime"),);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
