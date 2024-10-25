from django.contrib.auth.models import User
from rest_framework import serializers
from .models import UserProgress, Recipe, Ingredient, MealPlan

class UserRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    name = serializers.CharField()  # Asegúrate de que esto esté aquí

    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'name']

    def create(self, validated_data):
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        return user

# Serializador para el progreso del usuario
class UserProgressSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProgress
        fields = ['id', 'user', 'date', 'progress']

    def create(self, validated_data):
        validated_data['user'] = self.context['request'].user  # Asigna el usuario actual
        return super().create(validated_data)

# Serializador para las recetas
class RecipeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recipe
        fields = ['id', 'user', 'title', 'description', 'image', 'ingredients', 'likes'] 

# Serializador para los ingredientes
class IngredientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ingredient
        fields = ['id', 'user', 'name', 'icon']

    def create(self, validated_data):
        validated_data['user'] = self.context['request'].user  # Asigna el usuario actual
        return super().create(validated_data)

# Serializador para el plan de comidas
class MealPlanSerializer(serializers.ModelSerializer):
    class Meta:
        model = MealPlan
        fields = ['id', 'user', 'date', 'breakfast', 'lunch', 'snack', 'dinner']

    def create(self, validated_data):
        validated_data['user'] = self.context['request'].user  # Asigna el usuario actual
        return super().create(validated_data)
    
    