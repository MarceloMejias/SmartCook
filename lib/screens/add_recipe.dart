import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartcook/ingredient_manager.dart';
import 'package:smartcook/screens/add_ingredient_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final IngredientManager _ingredientManager = IngredientManager();
  CroppedFile? _imageFile;
  String? _selectedCategory;

  // Lista de categorías
  final List<String> _categories = ['Carnes', 'Cereales', 'Frutas', 'Verduras'];

  // Método para seleccionar una imagen de la galería
  Future<void> _pickImage() async {
    final status = await Permission.photos.request();
    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Permiso denegado para acceder a la galería.')),
      );
      return;
    }

    final ImagePicker _picker = ImagePicker();
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      final CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: selectedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          IOSUiSettings(minimumAspectRatio: 1.0),
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
        });
      }
    }
  }

  // Método para guardar una receta en la base de datos usando Supabase
  void _saveRecipe() async {
    List<String> ingredientNames = _ingredientManager.getIngredientNames();
    final title = _titleController.text;
    final description = _descriptionController.text;

    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Debes estar autenticado para agregar una receta.')),
      );
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una categoría.')),
      );
      return;
    }

    if (ingredientNames.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor añade al menos un ingrediente.')),
      );
      return;
    }

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una imagen.')),
      );
      return;
    }

    // Guardar receta en Supabase
    final file = File(_imageFile!.path);
    final String imagePath = 'images/${file.uri.pathSegments.last}';

    // Obtener URL de la imagen cargada
    final imageUrl = Supabase.instance.client.storage
        .from('recipe_images')
        .getPublicUrl(imagePath);

    // Guardar la receta en la base de datos
    final insertResponse = await Supabase.instance.client
        .from('recipes') // Reemplaza con el nombre de tu tabla
        .insert({
      'title': title,
      'description': description,
      'image': imageUrl, // Asegúrate de usar la URL de la imagen
      'category': _selectedCategory,
      'ingredients':
          ingredientNames, // Asegúrate de que tu base de datos esté preparada para esto
    });

    // Manejo de errores de inserción
    if (insertResponse.error != null) {
      final errorCode = insertResponse.error!.code;
      final errorMessage = insertResponse.error!.message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Error al agregar la receta: $errorCode - $errorMessage')),
      );
      return;
    }

    Navigator.pop(context);
  }

  // Método para añadir ingredientes
  void _addIngredient() {
    showDialog(
      context: context,
      builder: (context) {
        return AddIngredientDialog(
          ingredientManager: _ingredientManager,
        );
      },
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = _ingredientManager.getIngredients();

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
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 4,
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedCategory,
              hint: const Text('Selecciona una categoría'),
              isExpanded: true,
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addIngredient,
              child: const Text('Añadir Ingrediente'),
            ),
            const SizedBox(height: 16.0),
            ingredients.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ingredientes:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ...ingredients.map((ingredient) => Text(ingredient.name))
                    ],
                  )
                : const Text('No se han añadido ingredientes.'),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
