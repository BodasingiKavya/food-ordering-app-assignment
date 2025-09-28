
part of 'food_order_bloc.dart';


abstract class FoodOrderEvent extends Equatable {
  const FoodOrderEvent();
  @override
  List<Object> get props => [];
}

class LoadRestaurants extends FoodOrderEvent {}

class AddToCart extends FoodOrderEvent {
  final FoodItem item;
  const AddToCart(this.item);
  @override
  List<Object> get props => [item];
}

class RemoveFromCart extends FoodOrderEvent {
  final FoodItem item;
  const RemoveFromCart(this.item);
  @override
  List<Object> get props => [item];
}

class CheckoutOrder extends FoodOrderEvent {
  final AddressDetails address;
  const CheckoutOrder({required this.address});
  @override
  List<Object> get props => [address];
}

class CancelOrder extends FoodOrderEvent {
  final Order orderToCancel;
  const CancelOrder(this.orderToCancel);
  @override
  List<Object> get props => [orderToCancel];
}