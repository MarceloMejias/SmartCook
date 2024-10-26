![Banner](/banner.png)

Promoviendo una vida más saludable con recetas equilibradas.

Desarrollo de Aplicaciones Móviles 2024-2.

| Nombre         | Correo                |
| -------------- | --------------------- |
| Marcelo Mejías | marcelo.mejias@usm.cl |
| Paola Vásquez  | paola.vasquez@usm.cl  |
| x              | x@x.x                 |

---

## Descripción

**SmartCook** es una aplicación móvil que sirve de acompañamiento a los servicios que brinda un nutricionista. Promueve la alimentación saludable a través de recetas equilibradas y nutritivas.

Con una interfaz moderna y fácil de usar, la app ofrece a los usuarios acceso a una variedad de recetas adaptadas a sus preferencias dietéticas y necesidades nutricionales.

## Objetivo Principal

Diseñar y desarrollar una aplicación móvil que busca fomentar una vida más saludable proporcionando recetas accesibles y personalizables, además de integrar planes de actividad física adaptados, ayudando a los usuarios a tomar decisiones informadas sobre su dieta y bienestar.

## Objetivos Secundarios

1. **Implementar el Seguimiento Nutricional**: Integrar herramientas que permitan a los usuarios registrar sus hábitos alimenticios, los cuales la app transformará en un informe para un nutricionista.
2. **Implementar un sistema de monitoreo y metas**: Desarrollar una interfaz intuitiva para que los usuarios registren sus comidas, ejercicio y otras métricas de salud, generando informes revisables por nutricionistas.
3. **Compartir Recetas y Consejos**: Permitir a los usuarios compartir sus recetas favoritas y consejos de alimentación saludable con la comunidad, fomentando la interacción y el aprendizaje colectivo.

## Requisitos Funcionales

1. **Escalabilidad y capacidad de respuesta**: Asegurar que la infraestructura de la app pueda manejar un número creciente de usuarios y que las consultas nutricionales sean procesadas de manera eficiente, optimizando la capacidad de respuesta.
2. **Diseño de la interfaz y experiencia del usuario (UX/UI)**: Optimizar la interfaz para hacer que la experiencia de uso sea más intuitiva y atractiva, maximizando la retención y el compromiso de los usuarios.

## Interfaz

Material UI 3.

## Objetivo

Fomentar una vida más saludable proporcionando recetas accesibles y personalizables, ayudando a los usuarios a tomar decisiones informadas sobre su dieta y bienestar.

## Diseño del Logo

El logo es un brote de brócoli con un gorro de chef, representando la fusión entre la alimentación saludable y la cocina. El color verde simboliza la frescura y la salud, mientras que el gorro de chef añade un toque de profesionalismo y experiencia culinaria.

## Arquitectura Técnica

### Frontend Flutter

**SmartCook** se basa en una arquitectura que combina un frontend desarrollado con Flutter y un backend basado en Supabase/Django (por discutir). A continuación, se describen las principales características de cada componente:

- **Consumo de API**: Flutter se comunica con el backend a través de llamadas API con su backend en Supabase. Esto permite a la app obtener y enviar datos a la base de datos, como recetas, usuarios, comentarios, etc.

- **Autenticación y Gestión de Estado**: Flutter maneja la autenticación del usuario y el estado de la aplicación, permitiendo la autenticación mediante correo electrónico, redes sociales, etc.

### Backend Supabase

- **Base de Datos (PostgreSQL)**: Supabase proporciona una base de datos PostgreSQL que almacena todas las tablas necesarias para la app. Esto incluye tablas para recetas, usuarios, ingredientes, comentarios, etc. PostgreSQL permite consultas SQL avanzadas y es altamente escalable.
- **Autenticación**: Supabase ofrece autenticación de usuarios basada en varias opciones, como correo electrónico y redes sociales. Esto asegura que los usuarios puedan registrarse, iniciar sesión y gestionar sus perfiles de forma segura.
- **API Realtime**: Supabase genera automáticamente una API RESTful para interactuar con la base de datos. También ofrece funcionalidades de datos en tiempo real, lo que permite a la app actualizar los datos en tiempo real sin necesidad de recargar la app.
- **Almacenamiento de Archivos**: Supabase incluye almacenamiento de archivos para guardar imágenes de recetas y fotos de perfil de usuarios. Los archivos se almacenan en un bucket de almacenamiento, accesible mediante URL.
- **Reglas de Seguridad y Control de Acceso**: Podemos definir reglas de seguridad en Supabase para controlar quién puede acceder y modificar los datos en la base de datos. Esto asegura que solo los usuarios autenticados puedan realizar ciertas acciones, como guardar recetas o añadir comentarios.
