import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Інтернет-магазин',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StoreHomePage(),
    );
  }
}

// Моделі даних
class UserData {
  final String name;
  final String email;
  UserData(this.name, this.email);
}

class Product {
  final String title;
  final double price;
  Product(this.title, this.price);
}

class OrderItem {
  final int orderId;
  final String status;
  OrderItem(this.orderId, this.status);
}

class StoreHomePage extends StatefulWidget {
  const StoreHomePage({super.key});

  @override
  State<StoreHomePage> createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  UserData? _user;
  List<Product> _products = [];
  List<OrderItem> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDataFromAPI();
  }

  // Асинхронна функція для імітації запитів на сервер з затримкою
  Future<void> _loadDataFromAPI() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Імітуємо затримку завантаження користувача
      await Future.delayed(const Duration(seconds: 2));
      final user = UserData('Анастасія', 'demchuk@lntu.edu.ua');

      // Імітуємо затримку завантаження товарів
      await Future.delayed(const Duration(seconds: 1));
      final products = [
        Product('Смартфон', 12500.0),
        Product('Навушники', 2300.0),
        Product('Чохол для телефону', 450.0),
      ];

      // Імітуємо затримку завантаження замовлень
      await Future.delayed(const Duration(seconds: 1));
      final orders = [
        OrderItem(101, 'Доставлено'),
        OrderItem(102, 'В обробці'),
      ];

      setState(() {
        _user = user;
        _products = products;
        _orders = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Інтернет-магазин (Лаба 11)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Завантаження даних з сервера...'),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: _loadDataFromAPI,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Картка користувача
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Профіль користувача',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Text('Ім’я: ${_user?.name ?? ""}'),
                    Text('Email: ${_user?.email ?? ""}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Список товарів
            const Text(
              'Доступні товари:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._products.map((product) => Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_bag, color: Colors.indigo),
                title: Text(product.title),
                trailing: Text('${product.price} грн',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ),
            )),
            const SizedBox(height: 16),
            // Історія замовлень
            const Text(
              'Історія замовлень:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._orders.map((order) => Card(
              child: ListTile(
                leading: const Icon(Icons.receipt_long, color: Colors.orange),
                title: Text('Замовлення #${order.orderId}'),
                subtitle: Text('Статус: ${order.status}'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}