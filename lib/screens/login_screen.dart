import 'package:flutter/material.dart';
import 'package:httprequest/screens/all_products.dart';
import 'package:httprequest/services/api_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController(text: "mor_2314");
  TextEditingController passwordController = TextEditingController(text: "83r5^_");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WELCOME"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 50,
                width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: Text("Login",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                onPressed: () async {
                  final getToken = await ApiServices().userLogin(usernameController.text, passwordController.text);

                  if(getToken['token'] != null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login sucessfull"),backgroundColor: Colors.blueAccent,));
                    Future.delayed(Duration(seconds: 2),(){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllProductsScreen()));
                    });
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login attempt Unsucessfull"),backgroundColor: Colors.redAccent,));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
