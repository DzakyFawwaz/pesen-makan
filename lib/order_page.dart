import 'package:aplikasi_pemesanan_flutter/db_helper.dart';
import 'package:aplikasi_pemesanan_flutter/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'menu_data.dart';

class OrderPage extends StatelessWidget {
  final List<MenuItem> selectedItems;

  const OrderPage({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    DBHelper dbHelper = DBHelper();

    double total = selectedItems.fold(0, (sum, item) => sum + item.price ?? 0);
    int totalQuantity = selectedItems.fold(0, (sum, item) => sum + 1);

    final cart = Provider.of<MenuItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Order Summary",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                var item = selectedItems[index];

                return ListTile(
                  title: Text(item?.name ?? ""),
                  subtitle: Text("${NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(item?.price ?? 0)} x ${item?.quantity ?? 0}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.deleteCart(item.id).then((value) {
                        cart.removeCounter();
                        cart.removeTotalPrice(item.price);

                        selectedItems.removeAt(index);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "${item?.name ?? ""} removed from cart")),
                        );
                      }).catchError((error) {
                        print(error.toString());
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 20, spreadRadius: 2)
                ]),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text("Total Item"),
                        Spacer(),
                        Text(
                          "${totalQuantity ?? 0} Item",
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text("Total Harga"),
                        Spacer(),
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(total ?? 0),
                        )
                      ],
                    )
                  ],
                ),
                selectedItems.isNotEmpty
                    ? ElevatedButton(
                        onPressed: () {
                          dbHelper.clearCart();
                          selectedItems.clear();
                          cart.reset();
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Pesanan berhasil!")),
                          );
                        },
                        child: Text("Confirm Order"),
                      )
                    : Container(),
                //
              ],
            ),
          )
        ],
      ),
    );
  }
}
