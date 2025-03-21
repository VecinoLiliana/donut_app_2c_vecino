import 'package:donut_app_2c_vecino/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class PancakesTab extends StatelessWidget {
  final Function(double) onAddToCart;
  //lista de donas
  final List donutsOnSale = [
    // [ donutFlavor, donutText, donutPrice, donutColor, imageName ]
    ["HoneySun", "IHOP","150", Colors.yellow, "lib/images/honeySun_pancake.png"],
    ["CreamyCloud", "La libertad","173", Colors.deepPurple, "lib/images/CreamyCloud_pancake.png"],
    ["ChocoSplash", "Nutcafé","184", Colors.brown, "lib/images/chocoSplash_pancake.png"],
    ["CherryTop", "Manifesto","195", Colors.red, "lib/images/cherryTop_pancake.png"],

    ["HoneySun", "IHOP","150", Colors.yellow, "lib/images/honeySun_pancake.png"],
    ["CreamyCloud", "La libertad","173", Colors.deepPurple, "lib/images/CreamyCloud_pancake.png"],
    ["ChocoSplash", "Nutcafé","184", Colors.brown, "lib/images/chocoSplash_pancake.png"],
    ["CherryTop", "Manifesto","195", Colors.red, "lib/images/cherryTop_pancake.png"],
  ];
  PancakesTab({super.key, required this.onAddToCart});

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
