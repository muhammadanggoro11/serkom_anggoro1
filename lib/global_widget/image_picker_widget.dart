import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final String label;
  final String? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final List<String> extensions;
  final bool enabled;

  const ImagePickerWidget({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    required this.onChanged,
    this.extensions = const ["jpg", "png"],
    this.enabled = true,
  }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? imageFile;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.value ?? "-",
    );
    if (widget.value != null && widget.value!.isNotEmpty) {
      imageFile = File(widget.value!);
    }
  }

  Future<void> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
      print("Selected image path: ${image.path}");
      widget.onChanged(image.path);
      controller.text = image.path;
    }
  }

  Future<void> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
      print("Captured image path: ${image.path}");
      widget.onChanged(image.path);
      controller.text = image.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        onTap: () async {
          showModalBottomSheet(
            backgroundColor: Colors.grey[200],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Tombol kamera
                    ElevatedButton.icon(
                      onPressed: () {
                        getImageFromCamera();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.camera_alt_sharp),
                      label: const Text("Kamera"),
                    ),
                    // Tombol galeri
                    ElevatedButton.icon(
                      onPressed: () {
                        getImageFromGallery();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text("Galeri"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Ink(
          height: 200,
          decoration: BoxDecoration(
            image: imageFile != null
                ? DecorationImage(
                    image: FileImage(imageFile!),
                    fit: BoxFit.cover,
                  )
                : const DecorationImage(
                    image: AssetImage(
                      "assets/images/no_images.png",
                    ),
                    fit: BoxFit.cover,
                  ),
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          ),
        ),
      ),
    );
  }
}
