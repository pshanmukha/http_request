import 'package:flutter/material.dart';
import 'package:httprequest/screens/single_product.dart';
import 'package:httprequest/services/api_services.dart';

class CategoryProductScreen extends StatefulWidget {
final String categoryName;
CategoryProductScreen(this.categoryName);
  @override
  _CategoryProductScreenState createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  Future ? productByCategory;

  @override
  void initState() {
    // TODO: implement initState
    productByCategory = ApiServices().getProductByCategory(widget.categoryName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: productByCategory,
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
                      return GestureDetector(
                        child: Hero(
                          tag: snapshot.data[index]["id"],
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(snapshot.data[index]["image"],height: 180,width: 180,),
                                  Text(snapshot.data[index]["title"],textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  Text("\$: ${snapshot.data[index]["price"]}")
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SingleProduct(snapshot.data[index]["id"])));
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
