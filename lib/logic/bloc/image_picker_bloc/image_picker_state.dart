part of 'image_picker_bloc.dart';

class ImagePickerState extends Equatable {
  final File? file;

  const ImagePickerState({this.file});

  @override
  List<Object?> get props => [file];

  ImagePickerState copyWith({File? file}) {
    return ImagePickerState(
      file: file ?? this.file,
    );
  }
}
