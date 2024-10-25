from django.db import models
from django.contrib.auth.models import User

# Modelo para representar ingredientes
class Ingredient(models.Model):
    name = models.CharField(max_length=100)  # Nombre del ingrediente
    image = models.ImageField(upload_to='ingredients/')  # Imagen en miniatura del ingrediente

    def __str__(self):
        return self.name

# Modelo para representar recetas
class Recipe(models.Model):
    title = models.CharField(max_length=200)  # Título de la receta
    description = models.TextField()  # Descripción de la receta
    ingredients = models.ManyToManyField(Ingredient, related_name='recipes')  # Ingredientes asociados a la receta
    image = models.ImageField(upload_to='recipes/')  # Imagen de la receta
    user = models.ForeignKey(User, on_delete=models.CASCADE)  # Usuario que creó la receta
    likes = models.PositiveIntegerField(default=0)  # Campo para contar los likes

    def __str__(self):
        return self.title

# Modelo para registrar el progreso diario del usuario
class UserProgress(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)  # Usuario al que pertenece el progreso
    date = models.DateField()  # Fecha del progreso
    progress = models.FloatField(default=0.0)  # Progreso del usuario (0.0 a 1.0)

    class Meta:
        unique_together = ('user', 'date')  # Asegura que un usuario tenga solo un registro de progreso por día

    def __str__(self):
        return f"{self.user.username} - Progreso en {self.date}"

# Modelo para representar el plan de comidas del usuario
class MealPlan(models.Model):
    MEAL_TYPE_CHOICES = [
        ('desayuno', 'Desayuno'),
        ('almuerzo', 'Almuerzo'),
        ('colacion', 'Colación'),
        ('cena', 'Cena'),
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE)  # Usuario que registró la comida
    meal_type = models.CharField(max_length=20, choices=MEAL_TYPE_CHOICES)  # Tipo de comida
    date = models.DateField()  # Fecha de la comida
    recipes = models.ManyToManyField(Recipe, blank=True)  # Recetas asociadas a la comida
    notes = models.TextField(blank=True, null=True)  # Notas sobre la comida

    class Meta:
        unique_together = ('user', 'meal_type', 'date')  # Asegura que un usuario no registre la misma comida en el mismo día

    def __str__(self):
        return f"{self.user.username} - {self.meal_type} - {self.date}"
    