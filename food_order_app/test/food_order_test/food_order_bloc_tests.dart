// test/blocs/food_order_bloc_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:food_order_app/blocs/food_order_bloc.dart';

import 'package:food_order_app/blocs/food_order_state.dart';
import 'package:food_order_app/repository/food_repo.dart';

void main() {
  group('FoodOrderBloc', () {
    late FoodRepository repository;

    setUp(() {
      repository = FoodRepository();
    });

    test('initial state is FoodOrderLoading (or your initial state)', () {
      final bloc = FoodOrderBloc(repository);
      expect(bloc.state, isA<FoodOrderLoading>()); // adjust if initial is different
      bloc.close();
    });

    blocTest<FoodOrderBloc, FoodOrderState>(
      'emits [FoodOrderLoaded] when LoadRestaurants is added',
      build: () => FoodOrderBloc(repository),
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [isA<FoodOrderLoaded>()],
    );
  });
}
