import 'dart:collection';

// ignore: public_member_api_docs
class ChangeStack<T> {
  final Queue<Change<T>> _history = ListQueue();
  final Queue<Change<T>> _redos = ListQueue();

  // ignore: public_member_api_docs
  int max;

  // ignore: public_member_api_docs
  bool get canRedo => _redos.isNotEmpty;
  // ignore: public_member_api_docs
  bool get canUndo => _history.isNotEmpty && _history.length > 1;

  /// Undo/Redo History
  // ignore: sort_constructors_first
  ChangeStack({this.max});

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

// ignore: public_member_api_docs
class Change<T> {
  final T _oldValue;
  final Function _execute;
  final Function(T oldValue) _undo;

  // ignore: public_member_api_docs
  // ignore: sort_constructors_first
  // ignore: public_member_api_docs
  Change(
    this._oldValue,
    this._execute(),
    this._undo(T oldValue),
  );

  // ignore: public_member_api_docs
  void execute() {
    _execute();
  }

  // ignore: public_member_api_docs
  void undo() {
    _undo(_oldValue);
  }
}
