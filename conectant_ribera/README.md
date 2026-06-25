# Conectant Ribera

Aplicación móvil desarrollada con Flutter para consultar centros especializados y las asociaciones a las que pertenecen.

La app carga sus datos exclusivamente desde Supabase. Si Supabase no está configurado, no se muestran datos falsos: la aplicación enseña un mensaje de error para que se corrija la URL, la clave pública o las políticas de lectura.

## Funcionalidades

- Listado de centros especializados desde Supabase.
- Detalle de cada centro con nombre, dirección, descripción, imagen y asociación vinculada.
- Detalle de cada asociación con información de contacto y centros asociados.
- Navegación inferior entre Centros, Mapa y Asociaciones.
- Pantalla de mapa preparada como placeholder para una futura integración.

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

## Cómo ejecutar el proyecto con Supabase

Requisitos:

- Flutter SDK instalado.
- Un proyecto de Supabase creado.
- Las tablas creadas en la base de datos.
- Políticas RLS que permitan lectura pública si se usa la clave anon.

Comandos:

```powershell
cd c:\Projects\conectant_ribera
flutter pub get
flutter run --dart-define=SUPABASE_URL="https://TU-PROYECTO.supabase.co" --dart-define=SUPABASE_ANON_KEY="TU_ANON_KEY"
```


## Estructura del proyecto

```text
lib/
|-- main.dart                       # Punto de entrada de la aplicación
|-- data/
|   |-- app_data.dart               # Datos cargados y funciones de relación
|   |-- app_repository.dart         # Lectura de datos desde Supabase
|   `-- supabase_config.dart        # Configuración del cliente Supabase
|-- models/
|   |-- centro.dart                 # Modelo de centro
|   `-- association.dart            # Modelo de asociación
|-- screens/
|   |-- home_screen.dart            # Pantalla principal con navegación inferior
|   |-- centros_list.dart           # Listado de centros
|   |-- centro_detail.dart          # Detalle de centro
|   |-- entidades_screen.dart       # Listado de asociaciones
|   |-- association_detail.dart     # Detalle de asociación
|   |-- mapa_centros_screen.dart    # Pantalla de mapa en desarrollo
|   `-- map_view.dart               # Widget placeholder de mapa
`-- widgets/
    |-- bottom_nav.dart             # Barra de navegación inferior
    `-- centro_card.dart            # Tarjeta reutilizable para centros
```

## Estado actual

La aplicación cuenta con las siguientes funcionalidades implementadas:
- Pantalla principal con listado de centros especializados
- Pantalla de detalle de centro
- Pantalla de listado de asociaciones
- Pantalla de detalle de asociación
- Navegación inferior entre secciones
- Mapa interactivo con marcadores de centros y lista desplegable
- Conexión a Supabase para carga de datos
- Botón de recarga para actualizar datos desde Supabase

## Próximos pasos

- Integración de imágenes de centros desde assets o Supabase Storage
- Ajuste de estilos para fidelidad completa con el diseño Figma
- Posible implementación de favoritos o búsqueda
