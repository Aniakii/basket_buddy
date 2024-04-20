import 'dart:convert';
import 'package:basket_buddy/constants/exceptions.dart';
import 'package:basket_buddy/data/models/category.dart';
import 'package:basket_buddy/data/models/product.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/data/models/shopping_list_item.dart';
import 'package:basket_buddy/data/models/unit_enum.dart';
import 'package:basket_buddy/data/models/user.dart';
import 'package:http/http.dart' as http;

class BasketBuddyAPI {
  final client = http.Client();

  static const String baseURL =
      "https://basket-buddy-solvro-api.kowalinski.dev/api/v1";
  static const String logInURL = "$baseURL/auth/login/";
  static const String categoriesURL = "$baseURL/product-categories/";
  static const String productsURL = "$baseURL/products/";
  static const String shoppingListsURL = "$baseURL/shopping-lists/";
  static const String signUpURL = "$baseURL/auth/signup/";
  static const String logOutURL = "$baseURL/auth/logout/";

  static const String apiKey = "9054f7aa9305e012b3c2300408c3dfdf390fcddf";
  String? authToken;

  Future<User> logIn(String email, String password) async {
    final response = await client.post(
      Uri.parse(logInURL),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      authToken = jsonDecode(response.body)['token'];
      var userInformation = jsonDecode(response.body)['user'];
      User loggedUser = User(
          id: userInformation["id"],
          email: userInformation["email"],
          password: password);
      return loggedUser;
    } else if (response.statusCode == 400) {
      throw const FormatException('Wrong login or password');
    } else {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    }
  }

  Future<void> logOut() async {
    final response = await client.post(
      Uri.parse(logOutURL),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 204) {
    } else if (response.statusCode == 409) {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    } else {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    }
  }

  Future<User> signUp(String email, String password) async {
    final response = await client.post(
      Uri.parse(signUpURL),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      authToken = jsonDecode(response.body)['token'];
      var userInformation = jsonDecode(response.body)['user'];
      User registeredUser = User(
          id: userInformation["id"],
          email: userInformation["email"],
          password: password);
      return registeredUser;
    } else if (response.statusCode == 409) {
      throw AccountExistsException('Account with this email already exists.');
    } else if (response.statusCode == 400) {
      throw const FormatException(
          'Your mail is in wrong format or account with this email already exists');
    } else {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    }
  }

  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    dynamic data = await fetchData(urlString: productsURL);

    if (data != null) {
      List<dynamic> dataList = data;

      for (var data in dataList) {
        products.add(
          Product(
              id: data["id"],
              name: data["name"],
              categoryId: data["category"]["id"]),
        );
      }
    }
    return products;
  }

  Future<List<ShoppingList>> getShoppingLists() async {
    List<ShoppingList> shoppingLists = [];
    dynamic data = await fetchData(urlString: shoppingListsURL);

    if (data != null) {
      List<dynamic> dataList = data;

      for (var data in dataList) {
        List<ShoppingListItem> shoppingListItems =
            await getShoppingListItems(data["id"]);

        shoppingLists.add(ShoppingList(
            id: data["id"],
            name: data["name"],
            color: data["color"],
            emoji: data["emoji"],
            owner: data["owner"]));
        shoppingLists.last.items = shoppingListItems;
      }
    }
    return shoppingLists;
  }

  Future<List<ShoppingListItem>> getShoppingListItems(int listId) async {
    List<ShoppingListItem> shoppingListItems = [];
    dynamic data =
        await fetchData(urlString: '$shoppingListsURL$listId/items/');

    if (data != null) {
      List<dynamic> dataList = data;

      for (var data in dataList) {
        UnitEnum unit = UnitEnum.pieces;
        switch (data["unit"]) {
          case "pieces":
            unit = UnitEnum.pieces;
          case "kilogram":
            unit = UnitEnum.kilogram;
          case "gram":
            unit = UnitEnum.gram;
          case "liters":
            unit = UnitEnum.liters;
          case "meters":
            unit = UnitEnum.meters;
          default:
            unit = UnitEnum.pieces;
        }
        ShoppingListItem shoppingListItem = ShoppingListItem(
            id: data["id"],
            productId: data["product"]["id"],
            quantity: data["quantity"],
            unit: unit,
            isBought: data["isBought"]);
        shoppingListItems.add(shoppingListItem);
      }
    }

    return shoppingListItems;
  }

  Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    dynamic data = await fetchData(urlString: categoriesURL);

    if (data != null) {
      List<dynamic> dataList = data;

      for (var data in dataList) {
        categories.add(
          Category(id: data["id"], name: data["name"]),
        );
      }
    }
    return categories;
  }

  Future<void> addShoppingList(ShoppingList shoppingList) async {
    final shoppingListObject = {
      "name": shoppingList.name,
      "color": shoppingList.color,
      "emoji": shoppingList.emoji,
      "isActive": shoppingList.isActive
    };
    final response = await client.post(
      Uri.parse(shoppingListsURL),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $authToken'
      },
      body: jsonEncode(shoppingListObject),
    );
    if (response.statusCode == 201) {
    } else {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    }
  }

  Future<void> updateShoppingList(ShoppingList shoppingList) async {
    final shoppingListObject = {
      "name": shoppingList.name,
      "color": shoppingList.color,
      "emoji": shoppingList.emoji,
      "isActive": shoppingList.isActive
    };
    final response = await client.put(
      Uri.parse('$shoppingListsURL${shoppingList.id}/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $authToken'
      },
      body: jsonEncode(shoppingListObject),
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    }
  }

  Future<void> addShoppingListItem(
      ShoppingListItem shoppingListItem, int listId) async {
    var shoppingListItemObject = {
      "product_id": shoppingListItem.productId,
      "quantity": shoppingListItem.quantity,
      "unit": shoppingListItem.unit.toString().split('.').last.toUpperCase(),
      "isBought": shoppingListItem.isBought
    };
    final response = await client.post(
      Uri.parse('$shoppingListsURL$listId/items/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $authToken'
      },
      body: jsonEncode(shoppingListItemObject),
    );

    if (response.statusCode == 201) {
    } else {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    }
  }

  Future<void> updateShoppingListItem(
      ShoppingListItem shoppingListItem, int listId) async {
    var shoppingListItemObject = {
      "product_id": shoppingListItem.productId,
      "quantity": shoppingListItem.quantity,
      "unit": shoppingListItem.unit.toString().split('.').last.toUpperCase(),
      "isBought": shoppingListItem.isBought
    };
    final response = await client.put(
      Uri.parse('$shoppingListsURL$listId/items/${shoppingListItem.id}/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $authToken'
      },
      body: jsonEncode(shoppingListItemObject),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    }
  }

  Future<void> deleteShoppingList(int listId) async {
    final response = await client.delete(
      Uri.parse('$shoppingListsURL$listId/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $authToken'
      },
    );
    if (response.statusCode == 204) {
    } else {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    }
  }

  Future<void> deleteShoppingListItem(int itemId, int listId) async {
    final response = await client.delete(
      Uri.parse('$shoppingListsURL$listId/items/$itemId/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $authToken'
      },
    );

    if (response.statusCode == 204) {
    } else {
      throw Exception(
          'Unknown exception. failure code: ${response.statusCode}');
    }
  }

  Future<dynamic> fetchData({required String urlString}) async {
    if (authToken == null) {
      throw Exception();
    }
    final response = await client.get(
      Uri.parse(urlString),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $authToken'
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw response.statusCode;
    }
  }
}
