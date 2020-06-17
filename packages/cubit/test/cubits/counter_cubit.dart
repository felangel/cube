import 'package:cubit/cubit.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit({this.onTransitionCallback}) : super(initialState: 0);

  final void Function(Transition<Null, int>) onTransitionCallback;

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);

  @override
  void onTransition(Transition<Null, int> transition) {
    onTransitionCallback?.call(transition);
    super.onTransition(transition);
  }
}
