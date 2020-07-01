import 'package:replay_cubit/replay_cubit.dart';

class CounterCubit extends ReplayCubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
