part of 'counter_bloc.dart';

final class CounterState extends Equatable {
  final int counter;

  const CounterState({
    this.counter = 0,
  });

  @override
  List<Object> get props => [
        counter,
      ];

  CounterState copyWith({
    int? counter,
    bool? isSwitchOn,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}
