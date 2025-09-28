
import 'package:equatable/equatable.dart';
import '../../models/food_item.dart';
import '../../models/restaurant_model.dart';
import '../models/order_details.dart';

abstract class FoodOrderState extends Equatable {
  const FoodOrderState();
  @override
  List<Object> get props => [];
}

class FoodOrderInitial extends FoodOrderState {}
class FoodOrderLoading extends FoodOrderState {}

class FoodOrderLoaded extends FoodOrderState {
  final List<Restaurant> restaurants;
  final List<FoodItem> cart;
  final List<Order> pastOrders;

  const FoodOrderLoaded({
    this.restaurants = const [],
    this.cart = const [],
    this.pastOrders = const [],
  });

  FoodOrderLoaded copyWith({
    List<Restaurant>? restaurants,
    List<FoodItem>? cart,
    List<Order>? pastOrders,
  }) {
    return FoodOrderLoaded(
      restaurants: restaurants ?? this.restaurants,
      cart: cart ?? this.cart,
      pastOrders: pastOrders ?? this.pastOrders,
    );
  }

  @override
  List<Object> get props => [restaurants, cart, pastOrders];
}

class OrderSuccess extends FoodOrderState {}
class OrderFailure extends FoodOrderState{
  final String message;
  const OrderFailure({required this.message});
  @override
  List<Object> get props =>[message];
}

class Order extends Equatable {
  final List<FoodItem> items;
  final AddressDetails address;

  const Order({required this.items, required this.address});

  @override
  List<Object?> get props => [items, address];
}