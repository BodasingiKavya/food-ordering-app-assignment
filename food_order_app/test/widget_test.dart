// test/blocs/food_order_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/blocs/food_order_bloc.dart';
import 'package:food_order_app/blocs/food_order_state.dart';
import 'package:food_order_app/models/food_item.dart';
import 'package:food_order_app/models/order_details.dart';
import 'package:food_order_app/models/restaurant_model.dart';
import 'package:food_order_app/repository/food_repo.dart';

class FakeFoodRepository extends FoodRepository {
  bool shouldFail = false;

  @override
  Future<List<Restaurant>> getRestaurants() async {
    if (shouldFail) throw Exception("Repo error");
    return [
      Restaurant(
        id: "1",
        name: "Test Restaurant",
        imageUrl: "https://example.com/image.jpg",
        menu: [
          FoodItem(id: "f1", name: "Pizza", price: 9.99, imageUrl: '', rating: 2.4),
          FoodItem(id: "f2", name: "Burger", price: 5.99, imageUrl: '', rating: 3.5),
        ], rating: 4.3,
      ),
    ];
  }

  @override
  Future<void> checkoutOrder(List<FoodItem> cart) async {
    if (cart.isEmpty) throw Exception("Cart empty");
    if (shouldFail) throw Exception("Checkout failed");
    return;
  }
}

void main() {
  group('FoodOrderBloc', () {
    late FakeFoodRepository repository;

    setUp(() {
      repository = FakeFoodRepository();
    });

    test('initial state is FoodOrderInitial', () {
      final bloc = FoodOrderBloc(repository);
      expect(bloc.state, isA<FoodOrderInitial>());
      bloc.close();
    });

    blocTest<FoodOrderBloc, FoodOrderState>(
      'emits [FoodOrderLoading, FoodOrderLoaded] when LoadRestaurants succeeds',
      build: () => FoodOrderBloc(repository),
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        isA<FoodOrderLoading>(),
        isA<FoodOrderLoaded>().having(
              (s) => s.restaurants.length,
          'restaurants length',
          1,
        ),
      ],
    );

    blocTest<FoodOrderBloc, FoodOrderState>(
      'emits [FoodOrderLoading, OrderFailure] when LoadRestaurants fails',
      build: () {
        repository.shouldFail = true;
        return FoodOrderBloc(repository);
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        isA<FoodOrderLoading>(),
        isA<OrderFailure>(),
      ],
    );

    blocTest<FoodOrderBloc, FoodOrderState>(
      'emits updated cart when AddToCart is added',
      build: () => FoodOrderBloc(repository),
      seed: () => FoodOrderLoaded(
        restaurants: [],
        cart: [],
        pastOrders: [],
      ),
      act: (bloc) => bloc.add(AddToCart(FoodItem(id: "f1", name: "Pizza", price: 9.99, imageUrl: '', rating: 4.2))),
      expect: () => [
        isA<FoodOrderLoaded>().having(
              (s) => s.cart.length,
          'cart length',
          1,
        ),
      ],
    );

    blocTest<FoodOrderBloc, FoodOrderState>(
      'emits updated cart when RemoveFromCart is added',
      build: () => FoodOrderBloc(repository),
      seed: () => FoodOrderLoaded(
        restaurants: [],
        cart: [FoodItem(id: "f1", name: "Pizza", price: 9.99, imageUrl: '', rating: 4.3)],
        pastOrders: [],
      ),
      act: (bloc) => bloc.add(RemoveFromCart(FoodItem(id: "f1", name: "Pizza", price: 9.99, imageUrl: '', rating: 3.4))),
      expect: () => [
        isA<FoodOrderLoaded>().having(
              (s) => s.cart.isEmpty,
          'cart is empty',
          true,
        ),
      ],
    );

    blocTest<FoodOrderBloc, FoodOrderState>(
      'emits [OrderFailure] when CheckoutOrder is added with empty cart',
      build: () => FoodOrderBloc(repository),
      seed: () => FoodOrderLoaded(
        restaurants: [],
        cart: [],
        pastOrders: [],
      ),
      act: (bloc) => bloc.add(CheckoutOrder(address: AddressDetails(street: '123', city: 'Hello', postalCode: '45321'))),
      expect: () => [
        isA<OrderFailure>(),
      ],
    );

    blocTest<FoodOrderBloc, FoodOrderState>(
      'emits [OrderSuccess, FoodOrderLoaded with cleared cart and updated pastOrders] on successful checkout',
      build: () => FoodOrderBloc(repository),
      seed: () => FoodOrderLoaded(
        restaurants: [],
        cart: [FoodItem(id: "f1", name: "Pizza", price: 9.99, imageUrl: '', rating:  4.5)],
        pastOrders: [],
      ),
      act: (bloc) => bloc.add(CheckoutOrder(address:AddressDetails(street: '231', city: 'VZG', postalCode: '562345') )),
      expect: () => [
        isA<OrderSuccess>(),
        isA<FoodOrderLoaded>().having(
              (s) => s.pastOrders.length,
          'pastOrders length',
          1,
        ),
      ],
    );

    blocTest<FoodOrderBloc, FoodOrderState>(
      'emits updated state when CancelOrder is added',
      build: () => FoodOrderBloc(repository),
      seed: () => FoodOrderLoaded(
        restaurants: [],
        cart: [],
        pastOrders: [
          Order(
            items: [FoodItem(id: "f1", name: "Pizza", price: 9.99, imageUrl: '', rating: .4)],
            address: AddressDetails(street: '123', city: 'GPM', postalCode: '525370'),
          )
        ],
      ),
      act: (bloc) => bloc.add(CancelOrder(
        Order(items: [FoodItem(id: "f1", name: "Pizza", price: 9.99, imageUrl: '', rating: 3.4)], address: AddressDetails(street: '205', city: 'VZM', postalCode: '535270') ),
      )),
      expect: () => [
        isA<FoodOrderLoaded>()
            .having((s) => s.pastOrders.isEmpty, 'pastOrders empty', true)
            .having((s) => s.cart.length, 'cart length', 1),
      ],
    );
  });
}
