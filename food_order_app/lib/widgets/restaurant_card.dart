import 'package:flutter/material.dart';
import 'package:food_order_app/models/restaurant_model.dart';
import 'package:food_order_app/screens/restaurant_details.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RestaurantDetailsScreen(restaurant: restaurant),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ✅ Responsive image with aspect ratio
              Hero(
                tag: 'restaurant-image-${restaurant.id}',
                child: AspectRatio(
                  aspectRatio: 16 / 9, // keeps consistent look
                  child: Image.network(
                    restaurant.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// ✅ Responsive content padding
              Padding(
                padding: EdgeInsets.all(width * 0.04), // dynamic padding (4% of width)
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Restaurant Name
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: width * 0.05, // responsive font size
                      ),
                    ),
                    const SizedBox(height: 6),

                    /// Rating Row
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            color: Colors.amber, size: width * 0.05),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
