# Integración de Supabase - Guía de Configuración

La web ha sido conectada a Supabase para guardar formularios en la base de datos. Sigue estos pasos para completar la configuración.

## 1. Obtener Credenciales de Supabase

### Opción A: Supabase Local (Desarrollo)

Si usas Supabase localmente:

```bash
cd supabase
supabase start
```

Después de que se inicie, obtén las credenciales:

```bash
supabase status
```

Busca:
- `API URL` → `VITE_SUPABASE_URL`
- `anon key` → `VITE_SUPABASE_ANON_KEY`

### Opción B: Supabase Cloud

1. Ve a [supabase.com](https://supabase.com)
2. Crea un proyecto
3. Ve a "Project Settings" > "API"
4. Copia:
   - `Project URL` → `VITE_SUPABASE_URL`
   - `anon public` → `VITE_SUPABASE_ANON_KEY`

## 2. Configurar .env.local

El archivo `.env.local` ya está creado en la raíz del proyecto. Actualiza los valores:

```env
VITE_SUPABASE_URL=tu_url_aqui
VITE_SUPABASE_ANON_KEY=tu_anon_key_aqui
```

## 3. Crear la Tabla en la Base de Datos

Ejecuta el script SQL proporcionado en tu base de datos Supabase:

### Si usas Supabase Local:

```bash
psql postgres://postgres:postgres@localhost:54322/postgres < supabase_schema.sql
```

### Si usas Supabase Cloud:

1. Ve a "SQL Editor" en tu proyecto
2. Copia el contenido de `supabase_schema.sql`
3. Pégalo y ejecuta

Alternativamente, copia el contenido del archivo y ejecútalo línea por línea en el SQL Editor de Supabase.

## 4. Crear un Usuario de Prueba

### Si usas Supabase Local:

Ve a Supabase Studio (generalmente en `http://localhost:54323`) y ve a "Authentication" > "Users" para crear un usuario.

### Si usas Supabase Cloud:

Ve a tu proyecto en supabase.com > "Authentication" > "Users" > "Invite new user"

Recomendación:
- Email: `test@example.com`
- Password: `Test123456!`

## 5. Probar la Aplicación

1. Inicia la aplicación:
   ```bash
   npm run dev
   ```

2. Intenta hacer login con las credenciales del usuario creado

3. Usa el botón "Agregar" para guardar entidades o centros

4. Los datos deberían aparecer en la sección "Guardados"

5. Puedes editar y eliminar elementos

## 6. Verificar Datos en la Base de Datos

### Supabase Local:

Ve a Supabase Studio y abre la tabla `saved_items` para verificar que los datos se están guardando.

### Supabase Cloud:

Ve a tu proyecto > "Table Editor" y abre `saved_items`.

## 7. Solucionar Problemas

### Error: "Missing Supabase credentials in environment variables"

- Verifica que `.env.local` existe en la raíz del proyecto
- Verifica que `VITE_SUPABASE_URL` y `VITE_SUPABASE_ANON_KEY` no están vacíos
- Reinicia el servidor de desarrollo: `npm run dev`

### Login no funciona

- Verifica que el usuario existe en Supabase > Authentication > Users
- Verifica que la contraseña es correcta
- Asegúrate de que Row Level Security (RLS) está habilitado en la tabla

### Datos no se guardan

- Verifica que la tabla `saved_items` existe: SQL Editor > Ejecuta `SELECT * FROM saved_items;`
- Verifica que el usuario está autenticado
- Revisa la consola del navegador (F12) para ver los errores

### Error CORS

Si ves errores de CORS:
- Supabase Local: Generalmente no hay problema
- Supabase Cloud: Ve a "Project Settings" > "API" > "CORS" y agrega tu dominio

## Archivos Creados

- `.env.local` - Variables de entorno
- `src/lib/supabase.ts` - Cliente de Supabase
- `src/composables/useSupabase.ts` - Composables para auth y BD
- `supabase_schema.sql` - Script SQL para crear la tabla

## Cambios en Componentes

- `RegisterModal.vue` - Ahora usa Supabase auth
- `HomeView.vue` - Formulario conectado a la BD
- `userStore.ts` - Usa Supabase auth
- `BaseLayout.vue` - Logout usa Supabase

## Notas Importantes

- **Row Level Security (RLS)**: Está habilitado en la tabla. Cada usuario solo ve sus propios datos.
- **Autenticación**: El login ahora valida contra Supabase, no contra credenciales hardcodeadas.
- **Datos**: Se guardan en la tabla `saved_items` con el `user_id` del usuario autenticado.

## ¿Necesitas Ayuda?

Consulta la documentación de Supabase: https://supabase.com/docs
