# World Cup 2026 Panini Album

A full-stack web app that simulates a digital sticker album for the 2026 World Cup, with **React** on the frontend and **Express + MySQL** on the backend. Lets users register and manage a personal sticker inventory. Academic project for the Web Development course (Universidad de la Costa).

### What the project does

- Lets users **register** and **log in**, using the `usuarios` table in MySQL.
- Exposes a REST API built with Express, with routes for:
  * `GET /laminas` — full catalog (954 stickers, 40+ national teams plus the Coca-Cola collection).
  * `GET /inventario/:username` — the user's inventory, joining `inventario` and `laminas` with a `JOIN`.
  * `POST /inventario` — add a sticker to the inventory.
  * `PATCH /inventario/:id/pegar` — mark a sticker as pasted into the album.
  * `DELETE /inventario/:id` — remove a sticker from the inventory.
- The database (`bdalbum2026`) relates `usuarios`, `laminas`, and `inventario`, using an 8-level rarity `ENUM` ranging from `Común` to `Irremplazable`.
- The React frontend (`App.jsx`) consumes that API with `fetch` and provides:
  * A live search over the catalog by number, team, or player name.
  * A stats panel: total stickers, how many the user owns, how many are pasted, and how many are missing.
  * A distinct color per rarity level to spot the hardest-to-find stickers at a glance.
- Built with Vite, with automatic light/dark theming via CSS variables.

### How to run it

- Import `bdalbum2026_completo.sql` into MySQL.
- `cd backend && npm install && npm run dev` (listens on port 3000).
- `cd frontend && npm install && npm run dev` (listens on port 5173).
