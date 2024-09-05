import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/address.dart';
import '../models/favourite.dart';
import '../models/user.dart';

class DatabaseHelper {
  final databaseName = "ecommerceapp3.db";

  //user
  String user = '''
   CREATE TABLE users1 (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   firstName TEXT,
   lastName TEXT,
   email TEXT UNIQUE,
   password TEXT,
   imagePath TEXT
   )
   ''';

  //favourite
  String favouriteTable = '''
    CREATE TABLE favourites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    productId INTEGER,
    listId INTEGER
    )
    ''';
  String addressTable = '''
    CREATE TABLE address (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    streetAddress TEXT,
    city TEXT,
    state TEXT,
    zipCode TEXT,
    userId INTEGER,
    FOREIGN KEY(userId) REFERENCES users1(id)
    )
    ''';

  String paymentTable = '''
    CREATE TABLE payments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cardNumber TEXT,
    exp TEXT,
    cardHolderName TEXT,
    cvv INTEGER,
    userId INTEGER,
    FOREIGN KEY(userId) REFERENCES users1(id)
    )
    ''';
  String cartTable = '''
  CREATE TABLE carts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      listId INTEGER,
      size TEXT,
      color TEXT,
      quantity INTEGER,
      product TEXT,
      userId INTEGER,
      FOREIGN KEY(userId) REFERENCES users1(id)
    )
    ''';

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
 
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
      await db.execute(favouriteTable);
      await db.execute(addressTable);
      await db.execute(paymentTable);
      await db.execute(cartTable);

    });
  }

  //Authentication
  Future<bool> authenticate(User usr) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "SELECT * FROM users1 WHERE email = ? AND password = ?",
        [usr.email, usr.password]);
    return result.isNotEmpty;
  }

  //Sign up
  Future<int> createUser(User usr) async {
    final Database db = await initDB();
    return db.insert("users1", usr.toMap());
  }

  //Get
  Future<User?> getUser(String email) async {
    final Database db = await initDB();
    var res = await db.query("users1", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  //GetUserById
  Future<User?> getUserById(int id) async {
    final Database db = await initDB();
    var res = await db.query("users1", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  //updateUser
  Future<int> updateUser(User usr) async {
    final Database db = await initDB();
    return db.update(
      "users1",
      {
        "firstName": usr.firstName,
        "lastName": usr.lastName,
        "email": usr.email,
        "password": usr.password,
      },
      where: "id = ?",
      whereArgs: [usr.id],
    );
  }

  //addfavourite
  Future<int> addFavourite(Favourite favourite) async {
    final Database db = await initDB();
    return db.insert("favourites", favourite.toMap());
  }

  //getAllFavourites
  Future<List<Favourite>> getFavouritesByUserId(int userId) async {
    final Database db = await initDB();
    var res = await db.query(
      "favourites",
      where: "userId = ?",
      whereArgs: [userId],
    );
    return res.isNotEmpty ? res.map((f) => Favourite.fromMap(f)).toList() : [];
  }


//deletefavourite
  Future<int> removeFavourite(int productId, int listId) async {
    final Database db = await initDB();
    return db.delete("favourites",
        where: "productId = ? AND listId = ?", whereArgs: [productId, listId]);
  }

//isFavorit
  Future<bool> isFavorited(int productId, int userId) async {
    final Database db = await initDB();
    var res = await db.query(
      'favourites',
      where: 'productId = ? AND userId = ?',
      whereArgs: [productId, userId],
    );
    return res.isNotEmpty;
  }


  //addAddress
  Future<int> addAddress(Address address) async {
    final Database db = await initDB();
    return db.insert("address", address.toMapWithoutId());
  }
  //updateAddress
  Future<int> updateAddress(Address address) async {
    final Database db = await initDB();
    return db.update(
      "address",
      address.toMap(),
      where: "id = ?",
      whereArgs: [address.id],
    );
  }
  //deleteAddress
  Future<int> deleteAddress(int id) async {
    final Database db = await initDB();
    return db.delete(
      "address",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //getAllAddress
  Future<List<Address>> getAddressesByUserId(int userId) async {
    final Database db = await initDB();
    var res = await db.query("address", where: "userId = ?", whereArgs: [userId]);
    return res.isNotEmpty ? res.map((a) => Address.fromMap(a)).toList() : [];
  }

  //addPayment
  Future<int> addPayment(Payment payment) async {
    final Database db = await initDB();
    return db.insert("payments", payment.toMapWithoutId());
  }

  //updatePayment
  Future<int> updatePayment(Payment payment) async {
    final Database db = await initDB();
    return db.update(
      "payments",
      payment.toMap(),
      where: "id = ?",
      whereArgs: [payment.id],
    );
  }

  //deletePayment
  Future<int> deletePayment(int id) async {
    final Database db = await initDB();
    return db.delete(
      "payments",
      where: "id = ?",
      whereArgs: [id],
    );
  }
  //getAllPayment
  Future<List<Payment>> getPaymentByUserId(int userId) async {
    final Database db = await initDB();
    var res = await db.query("payments", where: "userId = ?", whereArgs: [userId]);
    return res.isNotEmpty ? res.map((a) => Payment.fromMap(a)).toList() : [];
  }


  //Update profile image
  Future<int> updateProfileImage(int userId, String imagePath) async {
    final Database db = await initDB();
    return db.update(
      "users1",
      {"imagePath": imagePath},
      where: "id = ?",
      whereArgs: [userId],
    );
  }

//Delete profile image
  Future<int> deleteProfileImage(int userId) async {
    final Database db = await initDB();
    return db.update(
      "users1",
      {"imagePath": null},
      where: "id = ?",
      whereArgs: [userId],
    );
  }

//Get profile image path
  Future<String?> getProfileImagePath(int userId) async {
    final Database db = await initDB();
    var res = await db.query(
      "users1",
      columns: ["imagePath"],
      where: "id = ?",
      whereArgs: [userId],
    );
    return res.isNotEmpty ? res.first["imagePath"] as String? : null;
  }

  Future<int> addCart(Cart cart) async {
    final Database db = await initDB();
    return await db.insert('carts', cart.toMap());
  }
  // Future<List<Payment>> getPaymentByUserId(int userId) async {
  //   final Database db = await initDB();
  //   var res = await db.query("payments", where: "userId = ?", whereArgs: [userId]);
  //   return res.isNotEmpty ? res.map((a) => Payment.fromMap(a)).toList() : [];
  // }
  // Future<List<Cart>> getCarts() async {
  //   final Database db = await initDB();
  //   final List<Map<String, dynamic>> maps = await db.query('carts');
  //
  //   return List.generate(maps.length, (i) {
  //     return Cart.fromMap(maps[i]);
  //   });
  // }
Future<List<Cart>> getCartByUserId(int userId) async{
    final Database db = await initDB();
    var res = await db.query('carts',where: 'userId = ?', whereArgs: [userId]);
    return res.isNotEmpty?res.map((e) => Cart.fromMap(e)).toList(): [];
}

  Future<int> updateCart(Cart cart) async {
    final Database db = await initDB();
    return await db.update(
      'carts',
      cart.toMap(),
      where: 'id = ?',
      whereArgs: [cart.id],
    );
  }

  Future<int> deleteCart(int id) async {
    final Database db = await initDB();
    return await db.delete(
      'carts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
