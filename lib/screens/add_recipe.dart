import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  CroppedFile? _imageFile;

  Future<void> _pickImage() async {
    // Verificar y solicitar permisos
    final status = await Permission.photos.request();
    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Permiso denegado para acceder a la galería.')),
      );
      return;
    }

    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? selectedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (selectedImage != null) {
        // Recortar la imagen a forma cuadrada
        final CroppedFile? croppedImage = await ImageCropper().cropImage(
          sourcePath: selectedImage.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),
            AndroidUiSettings(
              toolbarTitle: 'Recortar Imagen',
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
          ],
        );

        if (croppedImage != null) {
          setState(() {
            _imageFile = croppedImage;
            _imageUrlController.text = croppedImage
                .path; // O puedes usar la URL si la subes a un servidor
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar la imagen: $e')),
      );
    }
  }

  void _saveRecipe() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final imageUrl = _imageUrlController.text;

    // TODO: Guardar la receta en la base de datos

    // Regresar a la pantalla anterior
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Receta'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveRecipe,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Botón para cargar la imagen
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                    image: _imageFile != null
                        ? DecorationImage(
                            image: FileImage(File(_imageFile!.path)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _imageFile == null
                      ? const Icon(Icons.add_a_photo, size: 50)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16.0),
            // Solo para referencia, si decides guardar la URL
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'URL de la Imagen',
              ),
              readOnly: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveRecipe,
              child: const Text('Guardar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}
