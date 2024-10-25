from django import forms
from .models import Ingredient, Recipe, DailyProgress, Meal

class IngredientForm(forms.ModelForm):
    class Meta:
        model = Ingredient
        fields = ['name', 'image']

class RecipeForm(forms.ModelForm):
    class Meta:
        model = Recipe
        fields = ['title', 'description', 'ingredients', 'image']

class DailyProgressForm(forms.ModelForm):
    class Meta:
        model = DailyProgress
        fields = ['progress']

class MealForm(forms.ModelForm):
    class Meta:
        model = Meal
        fields = ['meal_type', 'date', 'recipes', 'notes']