import 'food_item.dart';

class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String? address;
  final String? phone;
  final List<FoodItem> menu;
  final List<Review>? reviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    this.address,
    this.phone,
    required this.menu,
    this.reviews,
  });
}

class Review {
  final String userName;
  final String comment;
  final int rating;

  Review({required this.userName, required this.comment, required this.rating});
}
