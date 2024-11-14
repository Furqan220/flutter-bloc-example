import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/utils/image_picker_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;
  ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerState()) {
    on<CameraCapture>(captureImage);
    on<PickImageFromGallery>(pickImage);
  }

  void captureImage(CameraCapture event, Emitter<ImagePickerState> emit) async {
    final XFile? file = await imagePickerUtils.captureImage();
    if (file != null) emit(state.copyWith(file: File(file.path)));
  }

  void pickImage(
      PickImageFromGallery event, Emitter<ImagePickerState> emit) async {
    final XFile? file = await imagePickerUtils.pickImage();
    if (file != null) emit(state.copyWith(file: File(file.path)));
  }
}
