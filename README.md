# 🍅 Muy Simple Pomodoro

Aplicación móvil de productividad diseñada para optimizar la gestión del tiempo mediante la técnica Pomodoro.

> **Estado:** Fase de desarrollo completada y en proceso de verificación para Google Play Store.

## Stack Técnico & Arquitectura

En este proyecto, mi prioridad fue organizar el código siguiendo estándares profesionales para que sea fácil de mantener y escalar:

* **Arquitectura MVVM (Model-View-ViewModel):** Separación clara de la lógica de negocio y la interfaz de usuario para un código mantenible.
* **Gestión de Estado (Provider):** Implementación de estados reactivos para el manejo preciso del temporizador.
* **Internacionalización (Slang):** Gestión de idiomas mediante generación de código tipado, garantizando seguridad y escalabilidad.
* **Persistencia:** Uso de `shared_preferences` para conservar las configuraciones de usuario.

## ✨ Características Principales

* **Ciclos Automáticos:** Flujo inteligente de trabajo (25 min) y descansos (5 min / 15 min largo).
* **Personalización:** Ajuste de duración de sesiones según la necesidad del usuario.
* **Control de Sesión:** Funcionalidad para saltar o reiniciar ciclos.
* **Interfaz Limpia:** Diseño enfocado en la usabilidad y la reducción de distracciones.

🚀 Instalación y Uso

Si deseas explorar o ejecutar este proyecto localmente:

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/ArlopDev/Muy_Simple_Pomodoro.git

2 **Obtener dependencias:**
    ```bash
    flutter pub get

3 **Generar archivos de Internacionalización:**
Este proyecto utiliza slang. Es necesario generar los archivos de traducción antes de ejecutar:
    ```bash
    dart run slang

4 **Ejecutar la aplicación:**
    ```bash
    flutter run

## 📸 Vista Previa

![HORIZONTAL_muestraOpciones_2](https://github.com/user-attachments/assets/fb5f5457-0fbb-49ea-94de-dc22de0e670a)
![HORIZONTAL_muestra_2](https://github.com/user-attachments/assets/a20463be-7076-4efe-943d-f0702f518493)
![HORIZONTAL_nuevaMuestra_pantallaPrincipal](https://github.com/user-attachments/assets/9a0d16ec-6ad1-473e-b369-db8547908380)
![HORIZONTAL_muestraPersonalizarNumero_1](https://github.com/user-attachments/assets/cb7a050e-ee68-45cd-b0f1-fabf221c32f9)

