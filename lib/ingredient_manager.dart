import 'package:collection/collection.dart'; // Necesario para firstWhereOrNull

class Ingredient {
  final String name;

  Ingredient(this.name);
}

class IngredientManager {
  final List<Ingredient> _ingredients = [];

  void addIngredient(String name) {
    if (name.isNotEmpty) {
      // Verifica si el ingrediente ya existe
      final existingIngredient = _ingredients.firstWhereOrNull(
          (ingredient) => ingredient.name.toLowerCase() == name.toLowerCase());

      if (existingIngredient == null) {
        _ingredients.add(Ingredient(name));
      } else {
        print('El ingrediente ya existe: ${existingIngredient.name}');
      }
    }
  }

  void removeIngredient(Ingredient ingredient) {
    _ingredients.remove(ingredient);
  }

  List<Ingredient> getIngredients() {
    return List.unmodifiable(_ingredients);
  }

  List<String> getIngredientNames() {
    return _ingredients.map((ingredient) => ingredient.name).toList();
  }
}
