import MapView from './components/MapView'
import './App.css'

function App() {
  return (
    <div className="app-container">
      <header className="app-header">
        <h1>WebGIS Fasilitas Transportasi Bandar Lampung</h1>
        <div className="legend">
          <span style={{color: '#e74c3c'}}>⬤ BRT</span>
          <span style={{color: '#3498db'}}>⬤ Bus</span>
          <span style={{color: '#2ecc71'}}>⬤ Angkot</span>
        </div>
      </header>
      <main className="map-wrapper">
        <MapView />
      </main>
    </div>
  )
}

export default App