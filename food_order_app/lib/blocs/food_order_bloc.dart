// lib/blocs/food_order_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/order_details.dart';
import '../repository/food_repo.dart';
import '../../models/food_item.dart';
import '../../models/restaurant_model.dart';
import 'food_order_state.dart';

part 'food_order_event.dart';

class FoodOrderBloc extends Bloc<FoodOrderEvent, FoodOrderState> {
  final FoodRepository repository;

  FoodOrderBloc(this.repository) : super( FoodOrderInitial()) {
    on<LoadRestaurants>((event, emit) async {
      // Preserve the current state to avoid data loss
      final currentState = state is FoodOrderLoaded ? state as FoodOrderLoaded : const FoodOrderLoaded();
      emit(FoodOrderLoading());
      try {
        final restaurants = await repository.getRestaurants();
        emit(currentState.copyWith(restaurants: restaurants));
      } catch (e) {
        emit(OrderFailure(message: "Failed to load restaurants: $e"));
      }
    });

    on<AddToCart>((event, emit) {
      if (state is FoodOrderLoaded) {
        final currentState = state as FoodOrderLoaded;
        final updatedCart = List<FoodItem>.from(currentState.cart)..add(event.item);
        emit(currentState.copyWith(cart: updatedCart));
      }
    });

    on<RemoveFromCart>((event, emit) {
      if (state is FoodOrderLoaded) {
        final currentState = state as FoodOrderLoaded;
        final updatedCart = List<FoodItem>.from(currentState.cart)..remove(event.item);
        emit(currentState.copyWith(cart: updatedCart));
      }
    });

    on<CheckoutOrder>((event, emit) async {
      if (state is FoodOrderLoaded) {
        final currentState = state as FoodOrderLoaded;
        if (currentState.cart.isEmpty) {
          emit(const OrderFailure(message: "Cart is empty."));
          return;
        }

        try {
          await repository.checkoutOrder(currentState.cart);

          emit(OrderSuccess());

          final newOrder = Order(items: currentState.cart, address: event.address);

          final updatedPastOrders = List<Order>.from(currentState.pastOrders)..add(newOrder);

          emit(currentState.copyWith(cart: [], pastOrders: updatedPastOrders));
        } catch (e) {
          emit(OrderFailure(message: "Checkout failed: $e"));
        }
      }
    });
    on<CancelOrder>((event, emit) {
      if (state is FoodOrderLoaded) {
        final currentState = state as FoodOrderLoaded;

        final updatedPastOrders = List<Order>.from(currentState.pastOrders);
        updatedPastOrders.remove(event.orderToCancel);

        final updatedCart = List<FoodItem>.from(currentState.cart)
          ..addAll(event.orderToCancel.items);

        emit(currentState.copyWith(
          pastOrders: updatedPastOrders,
          cart: updatedCart,
        ));
      }
    });

  }
}