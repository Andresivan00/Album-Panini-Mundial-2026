# Álbum Panini Mundial 2026

Aplicación web full-stack que simula un álbum digital de figuritas del Mundial 2026, con **React** en el frontend y **Express + MySQL** en el backend. Permite registrar usuarios y gestionar un inventario personal de láminas. Proyecto académico para la asignatura Desarrollo Web (Universidad de la Costa).

### Qué hace el proyecto

- Permite **registrar** e **iniciar sesión** con un usuario, usando la tabla `usuarios` de MySQL.
- Expone una API REST hecha con Express, con rutas para:
  * `GET /laminas` — catálogo completo (954 láminas, más de 40 selecciones y la colección Coca-Cola).
  * `GET /inventario/:username` — inventario del usuario, cruzando `inventario` y `laminas` con un `JOIN`.
  * `POST /inventario` — agregar una lámina al inventario.
  * `PATCH /inventario/:id/pegar` — marcar una lámina como pegada en el álbum.
  * `DELETE /inventario/:id` — eliminar una lámina del inventario.
- La base de datos (`bdalbum2026`) relaciona `usuarios`, `laminas` e `inventario`, con un `ENUM` de 8 niveles de rareza que va de `Común` a `Irremplazable`.
- El frontend en React (`App.jsx`) consume esa API con `fetch` y ofrece:
  * Buscador en vivo del catálogo por número, equipo o nombre del jugador.
  * Panel de estadísticas: total de láminas, cuántas tiene el usuario, cuántas pegó y cuántas le faltan.
  * Un color distinto por cada nivel de rareza para identificar las láminas más difíciles.
- Construido con Vite, con tema claro/oscuro automático mediante variables CSS.

### Cómo ejecutarlo

- Importar `bdalbum2026_completo.sql` en MySQL.
- `cd backend && npm install && npm run dev` (queda escuchando en el puerto 3000).
- `cd frontend && npm install && npm run dev` (queda escuchando en el puerto 5173).
