import 'dart:async';

import 'package:test/test.dart';

import 'cubits/counter_cubit.dart';

void main() {
  group('cubit', () {
    group('initial state', () {
      test('is correct', () {
        expect(CounterCubit().state, 0);
      });
    });

    group('undo/redo', () {
      test('undo check', () async {
        final states = <int>[];
        final cubit = CounterCubit();
        final subscription = cubit.listen(states.add);
        await Future<void>.delayed(Duration.zero, cubit.increment);
        await Future<void>.delayed(Duration.zero, cubit.increment);
        await Future<void>.delayed(Duration.zero, cubit.undo);
        await cubit.close();
        await subscription.cancel();
        expect(states, [0, 1, 2, 1]);
      });

      test('redo check', () async {
        final states = <int>[];
        final cubit = CounterCubit();
        final subscription = cubit.listen(states.add);
        await Future<void>.delayed(Duration.zero, cubit.increment);
        await Future<void>.delayed(Duration.zero, cubit.increment);
        await Future<void>.delayed(Duration.zero, cubit.undo);
        await Future<void>.delayed(Duration.zero, cubit.redo);
        await cubit.close();
        await subscription.cancel();
        expect(states, [0, 1, 2, 1, 2]);
      });
    });
  });
}
