
import 'package:flutter/material.dart';
import 'package:food_order_app/blocs/food_order_bloc.dart';
import 'package:food_order_app/models/restaurant_model.dart';
import 'package:food_order_app/widgets/food_item_card.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'restaurant-image-${restaurant.id}',
                child: Image.network(
                  restaurant.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(restaurant.name,style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    ...restaurant.menu.map((item) {
                      return FoodItemCard(item: item, onAdd: () {},);
                    }).toList(),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
