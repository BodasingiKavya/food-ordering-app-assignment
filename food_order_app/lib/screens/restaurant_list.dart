
// lib/screens/restaurant_list.dart
import 'package:flutter/material.dart';
import 'package:food_order_app/models/restaurant_model.dart';
import 'package:food_order_app/screens/cart_screen.dart';
import 'package:food_order_app/widgets/restaurant_card.dart';

class RestaurantsListScreen extends StatelessWidget {
  final List<Restaurant> restaurants;

  const RestaurantsListScreen({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants"),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen()));
          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return RestaurantCard(
            restaurant: restaurants[index],
          );
        },
      ),
    );
  }
}