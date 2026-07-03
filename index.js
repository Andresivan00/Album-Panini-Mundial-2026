// ── Importación de librerías ──────────────────────────
const express = require('express');   // Framework para crear el servidor web
const mysql = require('mysql2');      // Librería para conectarse a MySQL
const cors = require('cors');         // Permite que el frontend (React) se comunique con este backend
require('dotenv').config();           // Carga variables de entorno desde el archivo .env

// ── Configuración del servidor ────────────────────────
const app = express();
app.use(cors());             // Habilita CORS para aceptar peticiones desde otro puerto (ej: :5173)
app.use(express.json());     // Permite leer el cuerpo de las peticiones en formato JSON

// ── Conexión a la base de datos ───────────────────────
const db = mysql.createConnection({
  host: 'localhost',         // Servidor donde está MySQL (en este caso, la misma máquina)
  user: 'root',              // Usuario de MySQL
  password: 'ivan1109',      // Contraseña de MySQL
  database: 'bdalbum2026'    // Base de datos que vamos a usar
});

// Intenta conectarse; si falla muestra el error, si no confirma la conexión
db.connect(err => {
  if (err) console.error('Error conectando:', err);
  else console.log(' Conectado a MySQL');
});

// ════════════════════════════════════════════════════
// RUTAS DE LÁMINAS
// ════════════════════════════════════════════════════

// GET /laminas → devuelve todas las láminas del catálogo
app.get('/laminas', (req, res) => {
  db.query('SELECT * FROM laminas', (err, results) => {
    if (err) return res.status(500).json({ error: err }); // Si hay error, responde con código 500
    res.json(results); // Devuelve los resultados como JSON
  });
});

// ════════════════════════════════════════════════════
// RUTAS DE INVENTARIO
// ════════════════════════════════════════════════════

// GET /inventario/:username → devuelve las láminas que tiene un usuario
// Hace un JOIN para traer también los datos de la lámina (equipo, rareza, etc.)
app.get('/inventario/:username', (req, res) => {
  db.query(
    `SELECT i.*, l.nombre_jugador, l.equipo, l.rareza
     FROM inventario i
     JOIN laminas l ON i.numero_lamina = l.numero
     WHERE i.username = ?`,
    [req.params.username],  // El username viene en la URL, ej: /inventario/admin
    (err, results) => {
      if (err) return res.status(500).json({ error: err });
      res.json(results);
    }
  );
});

// POST /inventario → agrega una lámina al inventario del usuario
app.post('/inventario', (req, res) => {
  const { username, numero_lamina } = req.body; // Extrae los datos del cuerpo de la petición
  db.query(
    'INSERT INTO inventario (username, numero_lamina) VALUES (?, ?)',
    [username, numero_lamina],
    (err, result) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ mensaje: 'Lámina agregada', id: result.insertId }); // Devuelve el ID del nuevo registro
    }
  );
});

// DELETE /inventario/:id → elimina una lámina del inventario por su ID
app.delete('/inventario/:id', (req, res) => {
  db.query(
    'DELETE FROM inventario WHERE id_inventario = ?',
    [req.params.id], // El id viene en la URL, ej: /inventario/5
    (err) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ mensaje: 'Lámina eliminada' });
    }
  );
});

// PATCH /inventario/:id/pegar → marca una lámina como pegada en el álbum
app.patch('/inventario/:id/pegar', (req, res) => {
  db.query(
    'UPDATE inventario SET pegada = TRUE WHERE id_inventario = ?',
    [req.params.id],
    (err) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ mensaje: 'Lámina pegada' });
    }
  );
});

// ════════════════════════════════════════════════════
// RUTAS DE USUARIOS
// ════════════════════════════════════════════════════

// POST /login → verifica si el usuario y contraseña existen en la base de datos
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  db.query(
    'SELECT * FROM usuarios WHERE username = ? AND password = ?',
    [username, password],
    (err, results) => {
      if (err) return res.status(500).json({ error: err });
      if (results.length === 0)
        return res.status(401).json({ mensaje: 'Credenciales incorrectas' }); // 401 = no autorizado
      res.json({ mensaje: 'Login exitoso', usuario: results[0] }); // Devuelve los datos del usuario
    }
  );
});

// POST /usuarios → registra un nuevo usuario en la base de datos
app.post('/usuarios', (req, res) => {
  const { username, password, nombre, correo } = req.body;
  db.query(
    'INSERT INTO usuarios (username, password, nombre, correo) VALUES (?, ?, ?, ?)',
    [username, password, nombre, correo],
    (err) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ mensaje: 'Usuario registrado' });
    }
  );
});

// ── Inicia el servidor en el puerto 3000 ──────────────
app.listen(3000, () => console.log('Servidor en http://localhost:3000'));