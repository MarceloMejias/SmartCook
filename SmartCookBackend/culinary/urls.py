from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    UserProgressViewSet,
    RecipeViewSet,
    IngredientViewSet,
    MealPlanViewSet,
    UserRegistrationView,
    CustomTokenObtainPairView,
    RecipeLikeView,
)

# Crear un router para las vistas de la API
router = DefaultRouter()
router.register(r'progress', UserProgressViewSet, basename='userprogress')
router.register(r'recipes', RecipeViewSet, basename='recipes')
router.register(r'ingredients', IngredientViewSet, basename='ingredients')
router.register(r'mealplans', MealPlanViewSet, basename='mealplans')

urlpatterns = [
    # Ruta para el registro de usuarios
    path('register/', UserRegistrationView.as_view(), name='user-registration'),
    
    # Ruta para el inicio de sesión con JWT
    path('login/', CustomTokenObtainPairView.as_view(), name='token-obtain-pair'),

    # Ruta para dar like a una receta
    path('recipes/<int:recipe_id>/like/', RecipeLikeView.as_view(), name='recipe-like'),  # Nueva ruta para el "like"
    
    # Incluir las rutas del router
    path('', include(router.urls)),
]