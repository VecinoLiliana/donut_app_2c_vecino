import 'package:flutter/material.dart';


class DonnutTile extends StatelessWidget{
  final String donnutFlavor;
  final String donnutPrice;
  // Es dynamic porque será de tipo COLOR
  final dynamic donnutColor;
  final String imageName;

  const DonnutTile({super.key, required this.donnutFlavor, required this.donnutPrice, this.donnutColor, required this.imageName, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: donnutColor[50], borderRadius: BorderRadius.circular(24)),
      child: Column(children: [
        //PriceTag
        Row(
          //Alinea derecha
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: donnutColor[100], borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  topRight: Radius.circular(24)
                )),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 18),
              child: Text('\$$donnutPrice',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: donnutColor [800]
              ),
              ),
            ),

        ],),
        //Donut Picture
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical:12
            ),
          child: Image.asset(imageName),
        )

        // Donut Flavor Text

        // Buttons
        ],),
      ),
    ) ;
  }
}