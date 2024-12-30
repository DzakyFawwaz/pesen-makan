import 'package:flutter/material.dart';

class MenuItem {
  late final int id;
  final String name;
  final String image;
  final double price;
  final int quantity;

  MenuItem(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.quantity});

  MenuItem.fromMap(map)
      : id = map['id'],
        name = map['name'],
        image = map['image'],
        price = map['price'],
        quantity = map['quantity'];

  toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }
}

List<MenuItem> foodMenu = [
  MenuItem(
      id: 1,
      name: "Ayam Goreng",
      image: "assets/images/ayam_goreng.png",
      price: 9000,
      quantity: 0),
  MenuItem(
      id: 2,
      name: "Ikan Teri Kacang",
      image: "assets/images/ikan_teri_kacang.png",
      price: 3000,
      quantity: 0),
  MenuItem(
      id: 3,
      name: "Kentang Balado",
      image: "assets/images/kentang_balado.png",
      price: 3000,
      quantity: 0),
  MenuItem(
      id: 4,
      name: "Orek Tempe",
      image: "assets/images/orek_tempe.png",
      price: 4000,
      quantity: 0),
  MenuItem(
      id: 5,
      name: "Telur Dadar",
      image: "assets/images/telur_dadar.png",
      price: 7000,
      quantity: 0),
];

List<MenuItem> drinkMenu = [
  MenuItem(
      id: 6,
      name: "Kopi Hitam",
      image: "assets/images/kopi_hitam.png",
      price: 3000,
      quantity: 0),
  MenuItem(
      id: 7,
      name: "Es Teh",
      image: "assets/images/es_teh.png",
      price: 3000,
      quantity: 0),
  MenuItem(
      id: 8,
      name: "Es Jeruk",
      image: "assets/images/jus_jeruk.png",
      price: 5000,
      quantity: 0),
  MenuItem(
      id: 9,
      name: "Aqua",
      image: "assets/images/aqua.png",
      price: 2500,
      quantity: 0),
];

List<MenuItem> vegetablesMenu = [
  MenuItem(
      id: 10,
      name: "Sayur Asem",
      image: "assets/images/sayur_asem.png",
      price: 5000,
      quantity: 0),
  MenuItem(
      id: 11,
      name: "Sayur Sop",
      image: "assets/images/sayur_sop.png",
      price: 5000,
      quantity: 0),
  MenuItem(
      id: 12,
      name: "Cah Kangkung",
      image: "assets/images/cah_kangkung.png",
      price: 4000,
      quantity: 0),
  MenuItem(
      id: 13,
      name: "Sayur Buncis",
      image: "assets/images/sayur_buncis.png",
      price: 3000,
      quantity: 0),
];
