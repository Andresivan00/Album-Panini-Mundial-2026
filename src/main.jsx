// Importa StrictMode: activa advertencias extra en desarrollo para detectar errores
import { StrictMode } from 'react'

// Importa createRoot: función para montar la app React en el HTML
import { createRoot } from 'react-dom/client'

// Importa los estilos globales
import './index.css'

// Importa el componente principal de la aplicación
import App from './App.jsx'

// Busca el elemento <div id="root"> en el index.html y monta la app React ahí
createRoot(document.getElementById('root')).render(
  // StrictMode envuelve la app para mostrar advertencias en consola durante desarrollo
  // No afecta la versión final (producción)
  <StrictMode>
    <App />
  </StrictMode>,
)