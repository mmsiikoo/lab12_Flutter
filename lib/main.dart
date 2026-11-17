import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Змінні для даних
  String userResult = "Loading user...";
  String productResult = "Loading products...";
  String orderResult = "Loading orders...";

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  // асинхронна функція для користувача
  Future<String> fetchUser() async {
    await Future.delayed(Duration(seconds: 2));
    return "User: Anastasia (ademchuk0619@gmail.com)";
  }

  // асинхронна функція для товарів
  Future<String> fetchProducts() async {
    await Future.delayed(Duration(seconds: 2));
    return "Products: Smartphone, Headphones, Laptop";
  }

  // асинхронна функція для замовлень
  Future<String> fetchOrders() async {
    await Future.delayed(Duration(seconds: 2));
    return "Orders: #101 Delivered, #102 Pending";
  }

  // головна функція виконується за допомогою await
  void loadAllData() async {
    // очікування користувача
    String u = await fetchUser();

    // оновлення екрану
    setState(() {
      userResult = u;
    });

    // очікування товарів
    String p = await fetchProducts();
    setState(() {
      productResult = p;
    });

    // очікування замовленнь
    String o = await fetchOrders();
    setState(() {
      orderResult = o;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Async Program"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userResult,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              productResult,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              orderResult,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}