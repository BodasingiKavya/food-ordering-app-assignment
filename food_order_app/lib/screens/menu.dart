// // lib/screens/menu_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_order_app/screens/restaurant_details.dart';
// import '../blocs/food_order_bloc.dart';
// import '../models/restaurant_model.dart';
// import '../models/food_item.dart';
// import 'cart_screen.dart';
//
// class MenuScreen extends StatelessWidget {
//   final Restaurant restaurant;
//
//   const MenuScreen({super.key, required this.restaurant});
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<FoodOrderBloc>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: GestureDetector(
//           child:Text(restaurant.name),
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (_)=>RestaurantDetailsScreen(restaurant: restaurant,)));
//           },
//         ),
//         backgroundColor: Colors.deepOrange,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_cart),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => CartScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: restaurant.menu.length,
//         itemBuilder: (context, index) {
//           final FoodItem item = restaurant.menu[index];
//           return Card(
//             margin: const EdgeInsets.all(8),
//             child: Column(
//               children: [
//                 Image.network(item.imageUrl,
//                     width: double.infinity, height: 150, fit: BoxFit.cover),
//                 ListTile(
//                   title: Text(item.name),
//                   subtitle: Text("₹${item.price} • ⭐ ${item.rating}"),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.add_circle, color: Colors.deepOrange),
//                     onPressed: () {
//                       bloc.add(AddToCart(item));
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: const Text("Added to cart"),
//                           duration: const Duration(seconds: 1),
//                           action: SnackBarAction(
//                             label: "View Cart",
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => CartScreen()),
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
