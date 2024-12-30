import 'package:aplikasi_pemesanan_flutter/db_helper.dart';
import 'package:aplikasi_pemesanan_flutter/menu_data.dart';
import 'package:aplikasi_pemesanan_flutter/menu_provider.dart';
import 'package:aplikasi_pemesanan_flutter/order_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper dbHelper = DBHelper();

  Future<List<MenuItem>> _getCartItems() async {
    final cartData = await dbHelper.getCart();
    return cartData.map((item) => MenuItem.fromMap(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Warteg Bahari",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                CategorySection(
                  title: "Menu Utama",
                  menuList: foodMenu,
                  dbHelper: dbHelper,
                ),
                CategorySection(
                  title: "Sayur",
                  menuList: vegetablesMenu,
                  dbHelper: dbHelper,
                ),
                CategorySection(
                  title: "Minuman",
                  menuList: drinkMenu,
                  dbHelper: dbHelper,
                ),
              ],
            ),
          )),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 2)
            ]),
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Harga"),
                      Consumer<MenuItemProvider>(
                          builder: (context, value, child) {
                        return Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(value.totalPrice),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        );
                      }),
                    ],
                  ),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () async {
                    List<MenuItem> cartItems = await _getCartItems();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderPage(selectedItems: cartItems),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
                    backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      Consumer<MenuItemProvider>(
                          builder: (context, value, child) {
                        if (value.counter > 0) {
                          return Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              '${value.counter} Menu',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<MenuItem> menuList;
  final DBHelper dbHelper;

  const CategorySection(
      {super.key,
      required this.title,
      required this.menuList,
      required this.dbHelper});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<MenuItemProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 5),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 12),
            itemCount: menuList.length,
            itemBuilder: (context, index) {
              var menu = menuList[index];
              return Card(
                color: Colors.white,
                clipBehavior: Clip.hardEdge,

                // margin: EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(menu.image,
                                width: 160, height: 192, fit: BoxFit.cover),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                color: Colors.black54,
                                child: Text(
                                  NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp ',
                                    decimalDigits: 0,
                                  ).format(menu.price),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: 160,
                                padding: EdgeInsets.fromLTRB(15, 12, 50, 12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black38,
                                      Colors.black54,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Text(
                                  menu.name,
                                  style: TextStyle(
                                    height: 1,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -20,
                              right: -15,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.white),
                                    side: WidgetStateProperty.all(
                                        BorderSide(color: Colors.blueAccent)),
                                  ),
                                  onPressed: () {
                                    dbHelper.insertCart({
                                      'name': menuList[index].name,
                                      'image': menuList[index].image,
                                      'price': menuList[index].price,
                                      'quantity': 1
                                    }).then((value) {
                                      print("product is added to cart");

                                      cart.addTotalPrice(double.parse(
                                          menuList[index].price.toString()));
                                      cart.addCounter();
                                    }).onError((error, stackTrace) {
                                      print(error.toString());
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
