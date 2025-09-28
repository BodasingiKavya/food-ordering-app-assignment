// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/food_order_bloc.dart';
import '../blocs/food_order_state.dart';
import '../models/food_item.dart';
import '../models/order_details.dart';

import 'address_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.deepOrange,
      ),
      body: BlocConsumer<FoodOrderBloc, FoodOrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Order Confirmed!'),backgroundColor: Colors.deepOrange,),
              );
            // Navigate back to the main screen after a successful order
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is OrderFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.message),backgroundColor: Colors.deepOrange,),

              );
          }
        },
        builder: (context, state) {
          if (state is FoodOrderLoaded) {
            if (state.cart.isEmpty) {
              return const Center(
                child: Text(
                  'Your cart is empty!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }

            final cartItems = state.cart;
            final totalPrice = cartItems.fold(0.0, (sum, item) => sum + item.price);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Dismissible(
                        key: Key(item.id),
                        onDismissed: (direction) {
                          context.read<FoodOrderBloc>().add(RemoveFromCart(item));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${item.name} removed from cart.'),backgroundColor: Colors.deepOrange,),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(item.name),
                            subtitle: Text('₹${item.price.toStringAsFixed(2)}'),
                            trailing: IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  onPressed: () {
                                    context.read<FoodOrderBloc>().add(RemoveFromCart(item));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${item.name} removed from cart.'),backgroundColor: Colors.deepOrange,),
                                    );
                                  },
                                ),
                          ),
                        ),
                      );
                    //   Dismissible(
                    //     key: Key(item.id),
                    //     onDismissed: (direction) {
                    //       context.read<FoodOrderBloc>().add(RemoveFromCart(item));
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(content: Text('${item.name} removed from cart.')),
                    //       );
                    //     },
                    //     background: Container(
                    //       color: Colors.red,
                    //       alignment: Alignment.centerRight,
                    //       padding: const EdgeInsets.symmetric(horizontal: 20),
                    //       child: const Icon(Icons.delete, color: Colors.white),
                    //     ),
                    //     child: FoodItemCard(
                    //       item: item,
                    //       onRemove: () {
                    //         context.read<FoodOrderBloc>().add(RemoveFromCart(item));
                    //       },
                    //     ),
                    //   );
                    // },
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () async {
                            final AddressDetails? address = await showDialog<AddressDetails>(
                              context: context,
                              builder: (context) => const AddressDialog(),
                            );
                            if (address != null) {
                              context.read<FoodOrderBloc>().add(CheckoutOrder(address: address));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Address Saved !!",),
                                    backgroundColor: Colors.deepOrange,),

                              );
                            }
                          },
                          child: const Text('Confirm Order'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
