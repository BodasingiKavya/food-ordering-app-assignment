// lib/widgets/food_item_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/food_order_bloc.dart';
import '../models/food_item.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const FoodItemCard({
    super.key,
    required this.item,
    this.onAdd,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Container(
        width: width * 0.94,
        height: height*0.12,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                width: width*0.35,
                height: height*0.22,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    '₹${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            if (onAdd != null)
              IconButton(
                icon: const Icon(Icons.add_circle,
                    color: Colors.green, size: 30),
                onPressed: (){
                  context.read<FoodOrderBloc>().add(AddToCart(item));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.name} added to cart!'),
                      backgroundColor: Colors.deepOrange,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            if (onRemove != null)
              IconButton(
                icon: const Icon(Icons.remove_circle,
                    color: Colors.red, size: 30),
                onPressed: onRemove,
              ),
          ],
        ),
      ),
    );
  }
}
