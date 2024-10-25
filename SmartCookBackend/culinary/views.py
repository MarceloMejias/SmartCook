from rest_framework import viewsets, generics, permissions, views, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.views import TokenObtainPairView
from django.contrib.auth.models import User
from .models import UserProgress, Recipe, Ingredient, MealPlan
from .serializers import (
    UserProgressSerializer,
    RecipeSerializer,
    IngredientSerializer,
    MealPlanSerializer,
    UserRegistrationSerializer,
)

# Vista para manejar el registro de nuevos usuarios
class UserRegistrationView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserRegistrationSerializer
    permission_classes = [permissions.AllowAny]  # Permitir acceso a todos

# Vista para manejar el inicio de sesión usando JWT
class CustomTokenObtainPairView(TokenObtainPairView):
    permission_classes = [permissions.AllowAny]  # Permitir acceso a todos

    def post(self, request, *args, **kwargs):
        response = super().post(request, *args, **kwargs)
        # Personaliza la respuesta si es necesario
        return response

# Vista para manejar el progreso del usuario
class UserProgressViewSet(viewsets.ModelViewSet):
    queryset = UserProgress.objects.all()
    serializer_class = UserProgressSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        # Devuelve el progreso del usuario actual
        return self.queryset.filter(user=self.request.user)

# Vista para manejar las recetas
class RecipeViewSet(viewsets.ModelViewSet):
    queryset = Recipe.objects.all()
    serializer_class = RecipeSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        # Asigna el usuario actual a la receta al crear
        serializer.save(user=self.request.user)

# Vista para manejar los ingredientes
class IngredientViewSet(viewsets.ModelViewSet):
    queryset = Ingredient.objects.all()
    serializer_class = IngredientSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        # Asigna el usuario actual a los ingredientes al crear
        serializer.save(user=self.request.user)

# Vista para manejar el plan de comidas
class MealPlanViewSet(viewsets.ModelViewSet):
    queryset = MealPlan.objects.all()
    serializer_class = MealPlanSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        # Asigna el usuario actual al plan de comidas al crear
        serializer.save(user=self.request.user)

    def get_queryset(self):
        # Devuelve el plan de comidas del usuario actual
        return self.queryset.filter(user=self.request.user)
    
# Vista que entrega datos del usuario actual
class CurrentUserView(generics.RetrieveAPIView):
    serializer_class = UserRegistrationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_object(self):
        return self.request.user

# Vista para manejar los likes de las recetas
class RecipeLikeView(views.APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, recipe_id):
        try:
            recipe = Recipe.objects.get(id=recipe_id)
            recipe.likes += 1  # Incrementa el contador de likes
            recipe.save()
            return Response({'message': 'Like agregado!'}, status=status.HTTP_200_OK)
        except Recipe.DoesNotExist:
            return Response({'error': 'Receta no encontrada.'}, status=status.HTTP_404_NOT_FOUND)