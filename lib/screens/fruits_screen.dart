import 'package:flutter/material.dart';
import 'package:httprequest/models/fruits_model.dart';
import 'package:httprequest/services/api_services.dart';

class FruitsScreen extends StatefulWidget {
  const FruitsScreen({Key? key}) : super(key: key);

  @override
  _FruitsScreenState createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {

  Future ? _fruit;

  @override
  void initState() {
    // TODO: implement initState
    _fruit = ApiServices().getAllFruits();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruits"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _fruit,
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                  Fruit fruit = snapshot.data[index];
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      title: Center(child: Text(fruit.name)),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("carbohydrates: ${fruit.nutritions!.carbohydrates}"),
                          Text("protein: ${fruit.nutritions!.protein}"),
                          Text("fat: ${fruit.nutritions!.fat}"),
                        ],
                      ),
                    ),
                  );
                  });
            }
            else if(snapshot.hasError){}
            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
