//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../blocs/food_order_bloc.dart';
// import '../blocs/food_order_state.dart';
// import '../models/food_item.dart';
//
// class OrdersScreen extends StatelessWidget {
//   const OrdersScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Orders"),
//         backgroundColor: Colors.deepOrange,
//       ),
//       body: BlocBuilder<FoodOrderBloc, FoodOrderState>(
//         builder: (context, state) {
//           if (state is FoodOrderLoaded) {
//             if (state.pastOrders.isEmpty) {
//               return const Center(
//                 child: Text(
//                   "No confirmed orders yet",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               );
//             }
//
//             return ListView.builder(
//               itemCount: state.pastOrders.length,
//               itemBuilder: (context, index) {
//                 final order = state.pastOrders[index];
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: ExpansionTile(
//                     title: Text("Order #${index + 1}"),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("${order.items.length} items"),
//                         Text(
//                           "Delivered to: ${order.address.street}, ${order.address.city}, ${order.address.postalCode}",
//                           style: const TextStyle(fontSize: 12, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     children: order.items
//                         .map(
//                           (item) => ListTile(
//                         leading: Image.network(
//                           item.imageUrl,
//                           width: 40,
//                           height: 40,
//                           fit: BoxFit.cover,
//                         ),
//                         title: Text(item.name),
//                         subtitle: Text("₹${item.price}"),
//                       ),
//                     )
//                         .toList(),
//
//                   ),
//                 );
//               },
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }


// lib/screens/order_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/food_order_bloc.dart';
import '../blocs/food_order_state.dart';

import '../models/food_item.dart';
import 'cart_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen()));
          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: BlocBuilder<FoodOrderBloc, FoodOrderState>(
        builder: (context, state) {
          if (state is FoodOrderLoaded) {
            if (state.pastOrders.isEmpty) {
              return const Center(
                child: Text(
                  "No confirmed orders yet",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.pastOrders.length,
              itemBuilder: (context, index) {
                final order = state.pastOrders[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text("Order #${index + 1}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${order.items.length} items"),
                        Text(
                          "Delivered to: ${order.address.street}, ${order.address.city}, ${order.address.postalCode}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    children: [
                      ...order.items
                          .map(
                            (item) => ListTile(
                          leading: Image.network(
                            item.imageUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.name),
                          subtitle: Text("₹${item.price}"),
                        ),
                      )
                          .toList(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Remove Order From History"),
                                  content: const Text("Are you sure you want to Remove this order? It will be added back to your cart."),
                                  actions: [
                                    TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Remove"),
                                      onPressed: () {
                                        context.read<FoodOrderBloc>().add(CancelOrder(order));
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text("Remove Order", style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}