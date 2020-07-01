// ignore_for_file: public_member_api_docs
import 'dart:collection';

class ChangeStack<T> {
  /// Undo/Redo History
  ChangeStack({this.max});

  final Queue<Change<T>> _history = ListQueue();
  final Queue<Change<T>> _redos = ListQueue();

  int max;

  bool get canRedo => _redos.isNotEmpty;
  bool get canUndo => _history.isNotEmpty && _history.length > 1;

  /// Add New Change and Clear Redo Stack
  void add(Change<T> change) {
    change.execute();
    if (max != null && max == 0) {
      return;
    }

    _history.addLast(change);
    _redos.clear();

    if (max != null && _history.length > max) {
      if (max > 0) {
        _history.removeFirst();
      }
    }
  }

  /// Clear Undo History
  void clear() {
    _history.clear();
    _redos.clear();
  }

  /// Redo Previous Undo
  void redo() {
    if (canRedo) {
      final change = _redos.removeFirst()..execute();
      _history.addLast(change);
    }
  }

  /// Undo Last Change
  void undo() {
    if (canUndo) {
      final change = _history.removeLast()..undo();
      _redos.addFirst(change);
    }
  }
}

class Change<T> {
  Change(
    this._oldValue,
    this._execute(),
    this._undo(T oldValue),
  );

  final T _oldValue;
  final Function _execute;
  final Function(T oldValue) _undo;

  void execute() {
    _execute();
  }

  void undo() {
    _undo(_oldValue);
  }
}
