import 'package:flutter/material.dart';
import 'package:httprequest/screens/category_product_screen.dart';
import 'package:httprequest/services/api_services.dart';

class AllCategory extends StatefulWidget {

  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  Future ? category;

  @override
  void initState() {
    // TODO: implement initState
    category = ApiServices().getAllCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: category,
          builder: (contex, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                    itemBuilder: (context, index){
                    return Material(
                      child: InkWell(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProductScreen(snapshot.data[index])));},
                        child: Card(
                          margin: EdgeInsets.all(15),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Container(
                           padding: EdgeInsets.all(50),
                            child: Center(
                              child: Text(snapshot.data[index].toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                            ),
                          ),
                        ),
                      ),
                    );
                    }),
              );
            }
            else if(snapshot.hasError){
              return Center(child: Text("Unable to Process your request, Please try after sometime"),);
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
