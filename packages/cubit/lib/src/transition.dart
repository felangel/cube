import 'package:meta/meta.dart';

/// {@template transition}
/// Occurs when a new `state` is emitted from a `cubit`.
/// A [Transition] consists of the [currentState], [event], and [nextState].
/// {@endtemplate}
@immutable
class Transition<Event, State> {
  /// {@macro transition}
  const Transition({
    @required this.currentState,
    @required this.event,
    @required this.nextState,
  });

  /// The current [State] of the `cubit` at the time of the [Transition].
  final State currentState;

  /// The [Event] which triggered the current [Transition].
  /// [Event] can be `null` if it is unable to be determined.
  final Event event;

  /// The next [State] of the `cubit` at the time of the [Transition].
  final State nextState;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transition<Event, State> &&
          runtimeType == other.runtimeType &&
          currentState == other.currentState &&
          event == other.event &&
          nextState == other.nextState;

  @override
  int get hashCode {
    return currentState.hashCode ^ event.hashCode ^ nextState.hashCode;
  }

  @override
  String toString() {
    return '''Transition { currentState: $currentState, event: $event, nextState: $nextState }''';
  }
}
