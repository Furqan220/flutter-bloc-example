import 'package:bloc_practice/logic/bloc/image_picker_bloc/image_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Image Picker Bloc'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (_, state) {
                return CircleAvatar(
                  radius: 100,
                  backgroundImage:
                      state.file != null ? FileImage(state.file!) : null,
                  backgroundColor: Colors.grey.shade100,
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<ImagePickerBloc>().add(CameraCapture()),
                  icon: const Icon(
                    Icons.camera,
                  ),
                ),
                IconButton(
                  onPressed: () => context
                      .read<ImagePickerBloc>()
                      .add(PickImageFromGallery()),
                  icon: const Icon(
                    Icons.image,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
