import 'package:donut_app_2c_vecino/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class DonnutTab extends StatelessWidget {
  final Function(double) onAddToCart;
  //lista de donas
  final List donutsOnSale = [
    // [ donutFlavor, donutText, donutPrice, donutColor, imageName ]
    ["Ice Cream", "Krispy Kreme","36", Colors.blue, "lib/images/icecream_donut.png"],
    ["Strawberry", "Dunkin Donuts","45", Colors.red, "lib/images/strawberry_donut.png"],
    ["Grape Ape", "Aurrerá","84", Colors.purple, "lib/images/grape_donut.png"],
    ["Choco", "Costo","95", Colors.brown, "lib/images/chocolate_donut.png"],
    
    ["Ice Cream", "Krispy Kreme","36", Colors.blue, "lib/images/icecream_donut.png"],
    ["Strawberry", "Dunkin Donuts","45", Colors.red, "lib/images/strawberry_donut.png"],
    ["Grape Ape", "Aurrerá","84", Colors.purple, "lib/images/grape_donut.png"],
    ["Choco", "Costo","95", Colors.brown, "lib/images/chocolate_donut.png"],
  ];
  DonnutTab({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    // Widget para usar cuadricula
    return GridView.builder(
      // Cuántos elementos hay en una cuadricula
      itemCount: donutsOnSale.length,
      padding: EdgeInsets.all(12),
      // Prepa 1. Cómo se verán los elementos.
      gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          // Cuántas columnas
          crossAxisCount: 2,
          //Relación de aspecto (proporción)
          childAspectRatio: 1 / 1.5,
        ),
      
      itemBuilder: (context, index){
        // Cada elemento individual
        return DonnutTile(
        donnutFlavor: donutsOnSale[index][0],
        donnutText: donutsOnSale[index][1],
        donnutPrice: donutsOnSale [index][2],
        donnutColor: donutsOnSale[index][3],
        imageName: donutsOnSale[index][4],

        onAddToCart: () {
             double price = double.tryParse(donutsOnSale[index][2]) ?? 0;
             onAddToCart(price);
        },
        );
      },
    );
  }
}
