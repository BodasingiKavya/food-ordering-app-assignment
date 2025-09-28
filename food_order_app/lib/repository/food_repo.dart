// lib/repositories/food_repository.dart
import '../models/food_item.dart';
import '../models/restaurant_model.dart';
import 'dart:math';

class FoodRepository {
  final _rand = Random();

  // Cuisine-based sample dishes
  final Map<String, List<String>> cuisines = {
    "Indian": [
      "Butter Chicken", "Paneer Tikka", "Biryani", "Dal Makhani", "Aloo Paratha",
      "Chicken Curry", "Palak Paneer", "Chole Bhature", "Kadai Paneer", "Samosa",
      "Fish Curry", "Masala Dosa", "Idli Sambar", "Vada Pav", "Rajma Chawal",
    ],
    "Chinese": [
      "Hakka Noodles", "Veg Manchurian", "Chilli Chicken", "Spring Rolls", "Fried Rice",
      "Hot & Sour Soup", "Kung Pao Chicken", "Sweet Corn Soup", "Schezwan Fried Rice", "Dumplings",
    ],
    "South Indian": [
      "Masala Dosa", "Idli", "Medu Vada", "Upma", "Pongal",
      "Rasam", "Curd Rice", "Tomato Rice", "Onion Uttapam", "Filter Coffee",
    ],
    "North Indian": [
      "Naan", "Kulcha", "Tandoori Chicken", "Dal Tadka", "Mutton Rogan Josh",
      "Shahi Paneer", "Chana Masala", "Bhindi Fry", "Jeera Rice", "Lassi",
    ],
    "Korean": [
      "Bibimbap", "Kimchi Fried Rice", "Bulgogi", "Tteokbokki", "Japchae",
      "Kimchi Jjigae", "Korean Fried Chicken", "Samgyeopsal", "Sundubu Jjigae", "Kimbap",
    ],
  };

  // Word banks for random restaurant names
  final List<String> adjectives = [
    "Spicy", "Royal", "Golden", "Tasty", "Happy", "Flavors of", "Grand",
    "Hot & Fresh", "Urban", "Classic", "Fusion", "Crispy", "Savory",
    "Delight", "Magical", "Ocean", "Mountain", "Heritage", "Street",
  ];

  final List<String> cuisineKeywords = [
    "Biryani House", "Curry Point", "Dosa Corner", "Noodle Hub", "Sushi Bar",
    "Grill", "Kitchen", "BBQ", "Tandoor", "Kimchi Spot",
    "Rolls", "Kebab Junction", "Rice Bowl", "Thali Place", "Food Court",
    "Flavors", "Cafe", "Eatery", "Express", "Heaven",
  ];

  String _generateRestaurantName() {
    final adj = adjectives[_rand.nextInt(adjectives.length)];
    final keyword = cuisineKeywords[_rand.nextInt(cuisineKeywords.length)];
    return "$adj $keyword";
  }

  List<FoodItem> _generateMenu(String restaurantId, int count) {
    final List<FoodItem> menu = [];
    final allDishes = cuisines.values.expand((d) => d).toList();

    for (int i = 0; i < count; i++) {
      final dish = allDishes[_rand.nextInt(allDishes.length)];
      menu.add(
        FoodItem(
          id: "${restaurantId}_$i",
          name: dish,
          price: 5 + _rand.nextInt(20) + _rand.nextDouble(),
          imageUrl: "https://picsum.photos/200/${100 + _rand.nextInt(100)}",
          rating: 3.5 + _rand.nextDouble() * 1.5,
        ),
      );
    }
    return menu;
  }

  Future<List<Restaurant>> getRestaurants() async {
    await Future.delayed(const Duration(seconds: 1));

    List<Restaurant> restaurants = [];
    for (int i = 1; i <= 40; i++) {
      restaurants.add(
        Restaurant(
          id: "$i",
          name: _generateRestaurantName(),
          imageUrl: "https://picsum.photos/200/${200 + i}",
          rating: 3.5 + _rand.nextDouble() * 1.5,
          menu: _generateMenu("$i", 50),
        ),
      );
    }
    return restaurants;
  }

  Future<void> checkoutOrder(List<FoodItem> cart) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulated checkout
  }
}
