import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app/screens/order_screen.dart';

import '../blocs/food_order_bloc.dart';
import '../blocs/food_order_state.dart';
import '../widgets/custom_button.dart';
import '../../models/food_item.dart'; // Add this import

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FoodOrderBloc>();

    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<FoodOrderBloc, FoodOrderState>(
                builder: (context, state) {
                  if (state is FoodOrderLoaded) {
                    final cart = state.cart;
                    if (cart.isEmpty) return Center(child: Text("Cart is empty"));
                    double total = cart.fold(0, (sum, item) => sum + item.price);
                    return ListView(
                      children: [
                        ...cart.map((item) => ListTile(
                          title: Text(item.name),
                          trailing: Text("\$${item.price}"),
                        )),
                        SizedBox(height: 20),
                        Text("Total: \$${total.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    );
                  }
                  // Handle other states if needed, e.g., loading or initial
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            BlocConsumer<FoodOrderBloc, FoodOrderState>(
              listener: (context, state) {
                if (state is OrderSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Order placed successfully!")));
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else if (state is OrderFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return CustomButton(
                  text: "Confirm Order",
                  onPressed: () => bloc.add(OrdersScreen() as FoodOrderEvent),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}