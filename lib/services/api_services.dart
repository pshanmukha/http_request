import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:httprequest/models/fruits_model.dart';
import 'package:httprequest/models/product_model.dart';

class ApiServices {
  Future getAllProducts() async {
    var allProcuctsUrl = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(allProcuctsUrl);
    List <Product> allProducts =[];
    List body = json.decode(response.body);
    body.forEach((product) { allProducts.add(Product.fromJson(product));});
    log("All Products response : ${response.statusCode.toString()}");
    log("All Products body : ${response.body}");
    return allProducts;
  }

  Future getSingleProduct(int id) async {
    var singleProductUrl = Uri.parse('https://fakestoreapi.com/products/${id}');
    var response = await http.get(singleProductUrl);
    log("Single Product response : ${response.statusCode.toString()}");
    log("Single Product body : ${response.body}");
    return json.decode(response.body);
  }

  Future getAllCategory() async {
    var allCategoryUrl = Uri.parse('https://fakestoreapi.com/products/categories');
    var response = await http.get(allCategoryUrl);
    log("All Category response : ${response.statusCode.toString()}");
    log("All Category body : ${response.body}");
    return json.decode(response.body);
  }

  Future getProductByCategory(String categoryName) async {
    var productByCategoryUrl = Uri.parse('https://fakestoreapi.com/products/category/${categoryName}');
    var response = await http.get(productByCategoryUrl);
    log("Product By Category URL : ${productByCategoryUrl.toString()}");
    log("Product By Category response : ${response.statusCode.toString()}");
    log("Product By Category body : ${response.body}");
    return json.decode(response.body);
  }

  Future getCartItems(String userId) async {
    var cartUrl = Uri.parse('https://fakestoreapi.com/carts/${userId}');
    var response = await http.get(cartUrl);
    log("Cart URL : ${cartUrl.toString()}");
    log("Cart response : ${response.statusCode.toString()}");
    log("Cart body : ${response.body}");
    return json.decode(response.body);
  }

  //POST REQUEST

Future userLogin(String username,String password) async {
    final loginUrl = Uri.parse('https://fakestoreapi.com/auth/login');
    final response = await http.post(loginUrl,
        body: {
          'username': username,
          'password':password,
        } );
    log("Login URL : ${loginUrl.toString()}");
    log("Login response : ${response.statusCode.toString()}");
    log("Login body : ${response.body}");
    return json.decode(response.body); //returns the token
}

//PUT REQUEST
Future updateCart(int userId,int productId,) async {
    final updateCartUrl = Uri.parse('https://fakestoreapi.com/carts/$userId');
    final response = await http.put(updateCartUrl,
      body: {
      'userId':'${userId}',
        'date': DateTime.now().toString(),
        'products': [
          {
            'productId':productId,
            'quantity':'1',
          }
        ].toString()
      }
    );
    log("update Cart URL : ${updateCartUrl.toString()}");
    log("update Cart response : ${response.statusCode.toString()}");
    log("update Cart body : ${response.body}");
    return json.decode(response.body);
}

//DELETE REQUEST
Future deleteCartItem(int userId) async {
    final deleteCartItemUrl = Uri.parse('https://fakestoreapi.com/carts/$userId');
    final response = await http.delete(deleteCartItemUrl);
    log("Delete CartItem URL : ${deleteCartItemUrl.toString()}");
    log("Delete CartItem response : ${response.statusCode.toString()}");
    log("Delete CartItem body : ${response.body}");
    return json.decode(response.body);
}

  Future userAuthentication(String username,String password) async {
    final authUrl = Uri.parse('https://someawsserveroranyserver.com');
    String basicAuth = "Basic "+base64Encode(utf8.encode("$username :$password"));
    final response = await http.get(authUrl,
        headers: {
      "Content-Type":"application/json",
          "authorization":basicAuth,
        }
    );
    log("Auth URL : ${authUrl.toString()}");
    log("Auth response : ${response.statusCode.toString()}");
    log("Auth body : ${response.body}");
    return json.decode(response.body); //returns the token
  }
  
  //GET ALL FRUITS
Future <List<Fruit>> getAllFruits() async {
    final allFruitsUrl = Uri.parse("https://www.fruityvice.com/api/fruit/all");
    var response = await http.get(allFruitsUrl);
    List body = jsonDecode(response.body);
    List<Fruit> allFruits = body.map((fruit) => Fruit.fromJson(fruit)).toList();
    return allFruits;
}
}