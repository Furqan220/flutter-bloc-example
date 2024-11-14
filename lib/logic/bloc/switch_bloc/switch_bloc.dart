import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchState()) {
    on<ToggleEvent>(toggleSwitch);
    on<UpdateSliderValue>(updateSlider);
  }

  void toggleSwitch(ToggleEvent event, Emitter<SwitchState> emit) =>
      emit(state.copyWith(
        isOn: !state.isOn,
      ));

  void updateSlider(UpdateSliderValue event, Emitter<SwitchState> emit) =>
      emit(state.copyWith(
        sliderValue: event.sliderValue,
      ));
}
