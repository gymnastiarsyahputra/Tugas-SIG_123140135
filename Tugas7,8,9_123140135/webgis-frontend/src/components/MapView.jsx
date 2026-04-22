import { useState, useEffect } from 'react'
import { MapContainer, TileLayer, GeoJSON } from 'react-leaflet'
import L from 'leaflet'
import api from '../config/api'

function MapView() {
  const [geojsonData, setGeojsonData] = useState(null)

  // 1. Fetch Data GeoJSON dari API
  useEffect(() => {
    const fetchGeoJSON = async () => {
      try {
        // Memanggil endpoint GeoJSON yang kita buat di FastAPI
        const response = await api.get('/halte/geojson') 
        setGeojsonData(response.data)
      } catch (error) {
        console.error('Gagal mengambil data:', error)
      }
    }
    fetchGeoJSON()
  }, [])

  // 2. Styling Berbeda untuk Setiap Jenis Halte
  const getMarkerColor = (jenis) => {
    switch (jenis?.toLowerCase()) {
      case 'brt': return '#e74c3c'    // Merah
      case 'bus': return '#3498db'    // Biru
      case 'angkot': return '#2ecc71' // Hijau
      default: return '#95a5a6'       // Abu-abu
    }
  }

  // Mengubah Point geometri menjadi CircleMarker agar mudah diwarnai
  const pointToLayer = (feature, latlng) => {
    return L.circleMarker(latlng, {
      radius: 8,
      fillColor: getMarkerColor(feature.properties.jenis),
      color: '#fff',
      weight: 2,
      opacity: 1,
      fillOpacity: 0.8
    })
  }

  // 3. Popup dan Interaksi Hover (Highlight)
  const onEachFeature = (feature, layer) => {
    const { nama, jenis } = feature.properties
    
    // Implementasi Popup
    layer.bindPopup(`
      <div style="font-family: Arial, sans-serif;">
        <h3 style="margin: 0 0 5px 0; color: #333;">${nama}</h3>
        <p style="margin: 0;"><b>Jenis:</b> ${jenis?.toUpperCase()}</p>
      </div>
    `)

    // Implementasi Interaksi: Hover Highlight
    layer.on({
      mouseover: (e) => {
        const target = e.target
        target.setStyle({
          radius: 12, // Membesar saat di-hover
          weight: 3,
          fillOpacity: 1
        })
        target.openPopup()
      },
      mouseout: (e) => {
        const target = e.target
        target.setStyle({
          radius: 8, // Kembali ke ukuran semula
          weight: 2,
          fillOpacity: 0.8
        })
        target.closePopup()
      }
    })
  }

  return (
    // Tampilkan peta dengan center di Bandar Lampung
    <MapContainer 
      center={[-5.42, 105.26]} 
      zoom={13} 
      style={{ height: '100vh', width: '100%' }}
    >
      <TileLayer
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
      />
      
      {/* Tampilkan layer GeoJSON jika data sudah berhasil di-fetch */}
      {geojsonData && (
        <GeoJSON 
          data={geojsonData} 
          pointToLayer={pointToLayer}
          onEachFeature={onEachFeature}
        />
      )}
    </MapContainer>
  )
}

export default MapView