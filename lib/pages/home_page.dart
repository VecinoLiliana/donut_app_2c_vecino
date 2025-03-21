import 'package:donut_app_2c_vecino/tabs/burger_tab.dart';
import 'package:donut_app_2c_vecino/tabs/donnut_tab.dart';
import 'package:donut_app_2c_vecino/tabs/pancakes_tab.dart';
import 'package:donut_app_2c_vecino/tabs/pizza_tab.dart';
import 'package:donut_app_2c_vecino/tabs/smoothie_tab.dart';
import 'package:donut_app_2c_vecino/utils/my_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> myTabs = [
    const MyTab(iconPath: 'lib/icons/donut.png'),
    const MyTab(iconPath: 'lib/icons/burger.png'),
    const MyTab(iconPath: 'lib/icons/smoothie.png'),
    const MyTab(iconPath: 'lib/icons/pancakes.png'),
    const MyTab(iconPath: 'lib/icons/pizza.png')
  ];

// Variables del carrito
   int itemCount = 0;
   double totalPrice = 0.0;
 
   void addToCart(double price) {
     setState(() {
       itemCount++;
       totalPrice += price;
     });
   }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Icon(Icons.menu, color: Colors.grey[800]),
          // Ícono derecho
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Icon(Icons.person),
            )
          ],
        ),
        body: Column(
          children: [
            // Texto principal
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
              child: Row(
                children: [
                  Text("I want to ", style: TextStyle(fontSize: 32)),
                  Text("Eat",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ))
                ],
              ),
            ),
            // Pestañas (TabBar)
            TabBar(tabs: myTabs),
            // Contenido de pestañas (TabBarView)
            Expanded(
              child: TabBarView(
                children: [
                  DonnutTab(onAddToCart: addToCart),
                  BurgerTab(onAddToCart: addToCart),
                  SmoothieTab(onAddToCart: addToCart),
                  PancakesTab(onAddToCart: addToCart),
                  PizzaTab(onAddToCart: addToCart)
                ],
              ),
            ),
            // Carrito (Cart)
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                // Alinea los elementos a los extremos
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      // Alinear horizontalmente una columna
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$itemCount Items | \$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('Delivery Charges Included'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10
                        ),
                        Text(
                          'View Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}