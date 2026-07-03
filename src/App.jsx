import { useEffect, useState } from 'react';

// URL base del backend
const API = 'http://localhost:3000';

export default function App() {

  // ── Estados globales ──────────────────────────────────
  const [pantalla, setPantalla] = useState('login'); // Controla qué pantalla mostrar: login | registro | album
  const [usuario, setUsuario] = useState(null);      // Guarda los datos del usuario logueado
  const [laminas, setLaminas] = useState([]);         // Lista completa de láminas del catálogo
  const [inventario, setInventario] = useState([]);   // Láminas que tiene el usuario
  const [busqueda, setBusqueda] = useState('');       // Texto del buscador
  const [mensaje, setMensaje] = useState('');         // Mensaje de notificación temporal

  // Datos del formulario de login
  const [loginForm, setLoginForm] = useState({ username: '', password: '' });
  // Datos del formulario de registro
  const [regForm, setRegForm] = useState({ username: '', password: '', nombre: '', correo: '' });

  // ── Carga inicial de datos ────────────────────────────
  // Se ejecuta cada vez que cambia el usuario (cuando hace login)
  useEffect(() => {
    if (!usuario) return; // Si no hay usuario, no hace nada
    // Carga todas las láminas del catálogo
    fetch(`${API}/laminas`)
      .then(r => r.json())
      .then(setLaminas);
    // Carga el inventario del usuario
    cargarInventario();
  }, [usuario]);

  // Recarga el inventario del usuario desde el backend
  function cargarInventario() {
    fetch(`${API}/inventario/${usuario.username}`)
      .then(r => r.json())
      .then(setInventario);
  }

  // Muestra un mensaje por 3 segundos y luego lo oculta
  function mostrarMensaje(msg) {
    setMensaje(msg);
    setTimeout(() => setMensaje(''), 3000);
  }

  // ── Login ─────────────────────────────────────────────
  // Envía las credenciales al backend y si son correctas entra al álbum
  async function handleLogin(e) {
    e.preventDefault(); // Evita que la página se recargue al enviar el formulario
    const res = await fetch(`${API}/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(loginForm)
    });
    const data = await res.json();
    if (res.ok) {
      setUsuario(data.usuario);  // Guarda el usuario en el estado
      setPantalla('album');      // Navega al álbum
    } else {
      mostrarMensaje('❌ ' + data.mensaje); // Muestra el error
    }
  }

  // ── Registro ──────────────────────────────────────────
  // Crea un nuevo usuario y redirige al login
  async function handleRegistro(e) {
    e.preventDefault();
    const res = await fetch(`${API}/usuarios`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(regForm)
    });
    const data = await res.json();
    if (res.ok) {
      mostrarMensaje('✅ Usuario registrado, ahora inicia sesión');
      setPantalla('login'); // Redirige al login tras registrarse
    } else {
      mostrarMensaje('❌ Error al registrar');
    }
  }

  // ── Agregar lámina ────────────────────────────────────
  // Agrega una lámina al inventario del usuario si no la tiene ya
  async function agregarLamina(numero_lamina) {
    const yaLaTiene = inventario.some(i => i.numero_lamina === numero_lamina);
    if (yaLaTiene) { mostrarMensaje('⚠️ Ya tienes esa lámina'); return; }
    const res = await fetch(`${API}/inventario`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username: usuario.username, numero_lamina })
    });
    if (res.ok) {
      mostrarMensaje('✅ Lámina agregada');
      cargarInventario(); // Recarga el inventario para reflejar el cambio
    }
  }

  // ── Eliminar lámina ───────────────────────────────────
  // Elimina una lámina del inventario por su ID
  async function eliminarLamina(id) {
    const res = await fetch(`${API}/inventario/${id}`, { method: 'DELETE' });
    if (res.ok) {
      mostrarMensaje('🗑️ Lámina eliminada');
      cargarInventario();
    }
  }

  // ── Pegar lámina ──────────────────────────────────────
  // Marca una lámina como pegada en el álbum
  async function pegarLamina(id) {
    const res = await fetch(`${API}/inventario/${id}/pegar`, { method: 'PATCH' });
    if (res.ok) {
      mostrarMensaje('📌 Lámina pegada');
      cargarInventario();
    }
  }

  // Filtra el catálogo según lo que escribe el usuario en el buscador
  const laminasFiltradas = laminas.filter(l =>
    l.numero.toLowerCase().includes(busqueda.toLowerCase()) ||
    l.equipo.toLowerCase().includes(busqueda.toLowerCase()) ||
    l.nombre_jugador.toLowerCase().includes(busqueda.toLowerCase())
  );

  // Verifica si una lámina ya está en el inventario del usuario
  const tieneEnInventario = (numero) => inventario.some(i => i.numero_lamina === numero);

  // ════════════════════════════════════
  // PANTALLA LOGIN
  // ════════════════════════════════════
  if (pantalla === 'login') return (
    <div style={estilos.centrado}>
      <div style={estilos.card}>
        <h2 style={estilos.titulo}>🏆 Álbum Mundial 2026</h2>
        {/* Muestra el mensaje de error si existe */}
        {mensaje && <p style={estilos.mensaje}>{mensaje}</p>}
        <form onSubmit={handleLogin}>
          <input style={estilos.input} placeholder="Usuario"
            value={loginForm.username}
            onChange={e => setLoginForm({ ...loginForm, username: e.target.value })} />
          <input style={estilos.input} placeholder="Contraseña" type="password"
            value={loginForm.password}
            onChange={e => setLoginForm({ ...loginForm, password: e.target.value })} />
          <button style={estilos.boton} type="submit">Entrar</button>
        </form>
        {/* Enlace para ir a la pantalla de registro */}
        <p style={{ textAlign: 'center', marginTop: 10 }}>
          ¿No tienes cuenta?{' '}
          <span style={estilos.link} onClick={() => setPantalla('registro')}>Regístrate</span>
        </p>
      </div>
    </div>
  );

  // ════════════════════════════════════
  // PANTALLA REGISTRO
  // ════════════════════════════════════
  if (pantalla === 'registro') return (
    <div style={estilos.centrado}>
      <div style={estilos.card}>
        <h2 style={estilos.titulo}>📝 Registro</h2>
        {mensaje && <p style={estilos.mensaje}>{mensaje}</p>}
        <form onSubmit={handleRegistro}>
          <input style={estilos.input} placeholder="Usuario"
            value={regForm.username}
            onChange={e => setRegForm({ ...regForm, username: e.target.value })} />
          <input style={estilos.input} placeholder="Contraseña" type="password"
            value={regForm.password}
            onChange={e => setRegForm({ ...regForm, password: e.target.value })} />
          <input style={estilos.input} placeholder="Nombre completo"
            value={regForm.nombre}
            onChange={e => setRegForm({ ...regForm, nombre: e.target.value })} />
          <input style={estilos.input} placeholder="Correo"
            value={regForm.correo}
            onChange={e => setRegForm({ ...regForm, correo: e.target.value })} />
          <button style={estilos.boton} type="submit">Registrarse</button>
        </form>
        {/* Enlace para volver al login */}
        <p style={{ textAlign: 'center', marginTop: 10 }}>
          ¿Ya tienes cuenta?{' '}
          <span style={estilos.link} onClick={() => setPantalla('login')}>Inicia sesión</span>
        </p>
      </div>
    </div>
  );

  // ════════════════════════════════════
  // PANTALLA ÁLBUM (pantalla principal)
  // ════════════════════════════════════
  return (
    <div style={estilos.pagina}>

      {/* Barra superior con título, nombre del usuario y botón de cerrar sesión */}
      <div style={estilos.header}>
        <h1 style={{ margin: 0 }}>🏆 Álbum Mundial 2026</h1>
        <span>Hola, <strong>{usuario?.nombre}</strong></span>
        <button style={estilos.botonRojo} onClick={() => { setUsuario(null); setPantalla('login'); }}>
          Cerrar sesión
        </button>
      </div>

      {/* Notificación flotante en la esquina superior derecha */}
      {mensaje && <div style={estilos.mensajeFlotante}>{mensaje}</div>}

      {/* Tarjetas de resumen: total, tengo, pegadas, faltan */}
      <div style={estilos.stats}>
        <div style={estilos.statBox}>📦 Total láminas: <strong>{laminas.length}</strong></div>
        <div style={estilos.statBox}>✅ Tengo: <strong>{inventario.length}</strong></div>
        <div style={estilos.statBox}>📌 Pegadas: <strong>{inventario.filter(i => i.pegada).length}</strong></div>
        <div style={estilos.statBox}>❌ Faltan: <strong>{laminas.length - inventario.length}</strong></div>
      </div>

      <div style={estilos.contenido}>

        {/* ── Panel izquierdo: Catálogo completo con buscador ── */}
        <div style={estilos.panel}>
          <h3>📋 Catálogo de láminas</h3>
          {/* Campo de búsqueda: filtra por número, equipo o jugador */}
          <input style={estilos.input} placeholder="Buscar por número, equipo o jugador..."
            value={busqueda} onChange={e => setBusqueda(e.target.value)} />
          <div style={estilos.lista}>
            {/* Recorre las láminas filtradas y muestra cada una */}
            {laminasFiltradas.map(l => {
              const tengo = tieneEnInventario(l.numero);
              return (
                // Fondo verde si ya está en el inventario
                <div key={l.numero} style={{ ...estilos.itemLamina, background: tengo ? '#d4edda' : '#fff' }}>
                  <div>
                    <strong>{l.numero}</strong> — {l.equipo}
                    <br />
                    {/* Rareza con color según su nivel */}
                    <small style={{ color: colorRareza(l.rareza) }}>⭐ {l.rareza}</small>
                  </div>
                  {/* Si ya la tiene muestra ✅, si no muestra botón para agregar */}
                  {tengo
                    ? <span style={{ color: 'green' }}>✅ Tengo</span>
                    : <button style={estilos.botonPeq} onClick={() => agregarLamina(l.numero)}>+ Agregar</button>
                  }
                </div>
              );
            })}
          </div>
        </div>

        {/* ── Panel derecho: Inventario del usuario ── */}
        <div style={estilos.panel}>
          <h3>🗂️ Mi inventario</h3>
          <div style={estilos.lista}>
            {inventario.length === 0
              ? <p style={{ color: '#888' }}>Aún no tienes láminas.</p>
              : inventario.map(i => (
                // Fondo amarillo si la lámina ya fue pegada
                <div key={i.id_inventario} style={{ ...estilos.itemLamina, background: i.pegada ? '#fff3cd' : '#fff' }}>
                  <div>
                    <strong>{i.numero_lamina}</strong> — {i.equipo}
                    <br />
                    <small style={{ color: colorRareza(i.rareza) }}>⭐ {i.rareza}</small>
                    {i.pegada && <span style={{ marginLeft: 8, color: '#856404' }}>📌 Pegada</span>}
                  </div>
                  <div style={{ display: 'flex', gap: 4 }}>
                    {/* Solo muestra el botón pegar si aún no está pegada */}
                    {!i.pegada &&
                      <button style={estilos.botonAmarillo} onClick={() => pegarLamina(i.id_inventario)}>
                        📌 Pegar
                      </button>
                    }
                    {/* Botón para eliminar la lámina del inventario */}
                    <button style={estilos.botonRojo} onClick={() => eliminarLamina(i.id_inventario)}>
                      🗑️
                    </button>
                  </div>
                </div>
              ))
            }
          </div>
        </div>
      </div>
    </div>
  );
}

// Devuelve un color según la rareza de la lámina
function colorRareza(rareza) {
  const colores = {
    'Irremplazable': '#6f42c1',
    'Especial': '#0d6efd',
    'Ultra Valiosa': '#dc3545',
    'Super Valiosa': '#fd7e14',
    'Muy Valiosa': '#ffc107',
    'Valiosa': '#198754',
    'Poco Común': '#20c997',
    'Común': '#6c757d',
  };
  return colores[rareza] || '#333';
}

// ── Estilos en línea (objetos JS) ────────────────────
const estilos = {
  centrado: { display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '100vh', background: '#f0f2f5' },
  card: { background: '#fff', padding: 32, borderRadius: 12, boxShadow: '0 4px 20px rgba(0,0,0,0.1)', width: 360 },
  titulo: { textAlign: 'center', marginBottom: 20 },
  input: { width: '100%', padding: '10px 12px', marginBottom: 12, borderRadius: 8, border: '1px solid #ddd', boxSizing: 'border-box', fontSize: 14 },
  boton: { width: '100%', padding: '10px', background: '#0d6efd', color: '#fff', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 15 },
  botonRojo: { padding: '6px 10px', background: '#dc3545', color: '#fff', border: 'none', borderRadius: 6, cursor: 'pointer', fontSize: 13 },
  botonAmarillo: { padding: '6px 10px', background: '#ffc107', color: '#000', border: 'none', borderRadius: 6, cursor: 'pointer', fontSize: 13 },
  botonPeq: { padding: '6px 10px', background: '#198754', color: '#fff', border: 'none', borderRadius: 6, cursor: 'pointer', fontSize: 13 },
  link: { color: '#0d6efd', cursor: 'pointer', textDecoration: 'underline' },
  mensaje: { background: '#fff3cd', padding: '8px 12px', borderRadius: 6, marginBottom: 10, textAlign: 'center' },
  mensajeFlotante: { position: 'fixed', top: 20, right: 20, background: '#333', color: '#fff', padding: '10px 18px', borderRadius: 8, zIndex: 999 },
  pagina: { minHeight: '100vh', background: '#f0f2f5', fontFamily: 'sans-serif' },
  header: { background: '#0d6efd', color: '#fff', padding: '14px 24px', display: 'flex', alignItems: 'center', justifyContent: 'space-between' },
  stats: { display: 'flex', gap: 12, padding: '16px 24px', flexWrap: 'wrap' },
  statBox: { background: '#fff', padding: '10px 18px', borderRadius: 8, boxShadow: '0 2px 6px rgba(0,0,0,0.08)' },
  contenido: { display: 'flex', gap: 16, padding: '0 24px 24px', flexWrap: 'wrap' },
  panel: { flex: 1, minWidth: 300, background: '#fff', borderRadius: 10, padding: 16, boxShadow: '0 2px 8px rgba(0,0,0,0.08)' },
  lista: { maxHeight: 520, overflowY: 'auto' },        // Lista con scroll si hay muchas láminas
  itemLamina: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '10px 12px', marginBottom: 8, borderRadius: 8, border: '1px solid #eee' },
};