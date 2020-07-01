import 'package:cubit/cubit.dart';

import 'change_stack.dart';

/// {@template hydrated_cubit}
/// Specialized [Cubit] which handles initializing the [Cubit] state
/// based on the persisted state. This allows state to be persisted
/// across application restarts.
/// {@endtemplate}
abstract class ReplayCubit<State> extends Cubit<State> {
  /// {@macro hydrated_cubit}
  ReplayCubit(State state, {int maxChanges}) : super(state) {
    _changeStack = ChangeStack<State>(max: maxChanges);
  }

  /// Instance of [Storage] which will be used to
  /// manage persisting/restoring the [Cubit] state.
  static ChangeStack _changeStack;

  State _state;

  @override
  State get state {
    if (_state != null) return _state;
    return super.state;
  }

  @override
  void emit(State state) {
    _changeStack.add(Change<State>(
      _state,
      () {
        _state = state;
        super.emit(state);
      },
      (val) {
        _state = val;
        super.emit(val);
      },
    ));
  }

  /// Undo the last change
  void undo() => _changeStack.undo();

  /// Redo the previous change
  void redo() => _changeStack.redo();

  /// Checks whether the undo/redo stack is empty
  bool get canUndo => _changeStack.canUndo;

  /// Checks wether the undo/redo stack is at the current change
  bool get canRedo => _changeStack.canRedo;

  /// Clear undo/redo history
  void clear() => _changeStack.clear();
}
