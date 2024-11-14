part of 'switch_bloc.dart';

final class SwitchState extends Equatable {
  final bool isOn;
  final double sliderValue;

  const SwitchState({
    this.isOn = false,
    this.sliderValue = 0.5,
  });

  @override
  List<Object> get props => [
        isOn,
        sliderValue,
      ];

  SwitchState copyWith({
    bool? isOn,
    double? sliderValue,
  }) {
    return SwitchState(
      isOn: isOn ?? this.isOn,
      sliderValue: sliderValue ?? this.sliderValue,
    );
  }
}
