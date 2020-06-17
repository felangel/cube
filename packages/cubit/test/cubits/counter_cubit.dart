import 'package:cubit/cubit.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit({this.onTransitionCallback}) : super(initialState: 0);

  final void Function(Transition<Null, int>) onTransitionCallback;

  void increment({bool track}) => emit(state + 1, track: track);
  void decrement({bool track}) => emit(state - 1, track: track);

  @override
  void onTransition(Transition<Null, int> transition) {
    onTransitionCallback?.call(transition);
    super.onTransition(transition);
  }
}
