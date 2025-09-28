import 'package:flutter_test/flutter_test.dart';
import 'package:food_order_app/blocs/food_order_bloc.dart';
import 'package:food_order_app/blocs/food_order_state.dart';
import 'package:food_order_app/repository/food_repo.dart';
import 'package:bloc_test/bloc_test.dart';

// Import the main bloc file, which exposes all classes from its "parts"
// The FoodOrderEvent and FoodOrderState classes will be available from here
// after the previous corrections to your bloc, event, and state files.

void main() {
  group('FoodOrderBloc', () {
    late FoodOrderBloc bloc;
    late FoodRepository repository;

    setUp(() {
      repository = FoodRepository();
      bloc = FoodOrderBloc(repository);
    });

    test('Initial state is FoodOrderInitial', () {
      expect(bloc.state, FoodOrderInitial());
    });

    blocTest<FoodOrderBloc, FoodOrderState>(
      'emits RestaurantsLoading and RestaurantsLoaded when LoadRestaurants is added',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadRestaurants()),
      // expect: () => [isA<RestaurantsLoading>(), isA<RestaurantsLoaded>()],
    );
  });
}