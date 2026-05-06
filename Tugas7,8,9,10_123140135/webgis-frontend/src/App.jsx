import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import { AuthProvider, useAuth } from './context/AuthContext'
import MapView from './components/MapView'
import Login from './components/Login'
import './App.css'

// Komponen pelindung: lempar ke /login jika belum ada token
function ProtectedRoute({ children }) {
  const { user } = useAuth()
  return user ? children : <Navigate to="/login" />
}

// Kerangka utama aplikasi (Peta + Tombol Logout)
function MainApp() {
  const { logout } = useAuth()
  return (
    <div className="app-container">
      <header className="app-header">
        <h1>WebGIS Fasilitas Transportasi</h1>
        <button onClick={logout} style={{ padding: '8px 15px', backgroundColor: '#e74c3c', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer', fontWeight: 'bold' }}>
          Logout
        </button>
      </header>
      <main className="map-wrapper">
        <MapView />
      </main>
    </div>
  )
}

export default function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/" element={
            <ProtectedRoute>
              <MainApp />
            </ProtectedRoute>
          } />
        </Routes>
      </Router>
    </AuthProvider>
  )
}