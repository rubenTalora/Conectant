# Conectant Ribera

Aplicación móvil desarrollada con Flutter para consultar centros especializados y las asociaciones a las que pertenecen.

El objetivo del proyecto es mostrar una estructura clara de navegación: una pantalla principal con centros individuales, una pantalla de mapa en desarrollo y una pantalla de asociaciones donde se agrupan los centros vinculados a cada entidad.

## Funcionalidades

- Listado de centros especializados.
- Detalle de cada centro con nombre, dirección, descripción, imagen y asociación vinculada.
- Listado de asociaciones.
- Detalle de cada asociación con información de contacto y centros asociados.
- Navegación inferior entre Centros, Mapa y Asociaciones.
- Pantalla de mapa preparada como placeholder para una futura integración.
- Datos de prueba definidos localmente en `mock_data.dart`.

## Modelo de datos

El proyecto usa dos modelos principales:

- `Centro`: representa un centro individual. Cada centro tiene un identificador, nombre, dirección, coordenadas, descripción y el identificador de la asociación a la que pertenece.
- `Association`: representa una asociación o entidad. Una asociación puede tener varios centros asociados.

La relación es:

```text
1 asociación -> muchos centros
1 centro -> 1 asociación
```

Por eso, en la pantalla inicial aparecen todos los centros de forma independiente, y en la pantalla de asociaciones aparecen las asociaciones con sus centros agrupados.

## Estructura del proyecto

```text
lib/
├── main.dart                       # Punto de entrada de la aplicación
├── data/
│   └── mock_data.dart              # Datos de prueba y funciones auxiliares
├── models/
│   ├── centro.dart                 # Modelo de centro
│   └── association.dart            # Modelo de asociación
├── screens/
│   ├── home_screen.dart            # Pantalla principal con navegación inferior
│   ├── centros_list.dart           # Listado de centros
│   ├── centro_detail.dart          # Detalle de centro
│   ├── entidades_screen.dart       # Listado de asociaciones
│   ├── association_detail.dart     # Detalle de asociación
│   ├── mapa_centros_screen.dart    # Pantalla de mapa en desarrollo
│   └── map_view.dart               # Widget placeholder de mapa
└── widgets/
    ├── bottom_nav.dart             # Barra de navegación inferior
    └── centro_card.dart            # Tarjeta reutilizable para centros
```

## Cómo ejecutar el proyecto

Requisitos:

- Flutter SDK instalado.
- Un emulador, navegador o dispositivo configurado.

Comandos:

```powershell
cd c:\Projects\conectant_ribera
flutter pub get
flutter run
```

## Estado actual

La aplicación tiene implementadas las pantallas principales, la navegación y la relación entre centros y asociaciones. La parte del mapa todavía está en desarrollo y actualmente muestra una pantalla informativa.

## Próximos pasos

- Integrar un mapa real usando las coordenadas de cada centro.
- Sustituir los datos mock por una base de datos o API.
- Añadir imágenes definitivas desde los assets del diseño.
- Pulir estilos para ajustarlos completamente a los bocetos de Figma.
