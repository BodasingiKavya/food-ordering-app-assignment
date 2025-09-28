
// lib/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/food_order_bloc.dart';
import '../blocs/food_order_state.dart';
import 'restaurant_list.dart';
import 'order_screen.dart';
import 'cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Dispatch the LoadRestaurants event only when the screen is first created
    if (context.read<FoodOrderBloc>().state is! FoodOrderLoaded) {
      context.read<FoodOrderBloc>().add(LoadRestaurants());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FoodOrderBloc, FoodOrderState>(
        builder: (context, state) {
          if (state is FoodOrderLoaded) {
            final List<Widget> screens = [
              RestaurantsListScreen(restaurants: state.restaurants),
              const OrdersScreen(),
              CartScreen(),
            ];
            return screens[_selectedIndex];
          } else if (state is FoodOrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderFailure) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("Welcome to Food Order App!"));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            // No longer dispatching LoadRestaurants on every home tab tap
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "My Cart"),
        ],
      ),
    );
  }
}