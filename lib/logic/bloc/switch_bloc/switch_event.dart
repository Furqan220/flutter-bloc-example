part of 'switch_bloc.dart';

sealed class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

class ToggleEvent extends SwitchEvent {}

class UpdateSliderValue extends SwitchEvent {
  final double sliderValue;
  const UpdateSliderValue({required this.sliderValue});

  @override
  List<Object> get props => [sliderValue];
}
