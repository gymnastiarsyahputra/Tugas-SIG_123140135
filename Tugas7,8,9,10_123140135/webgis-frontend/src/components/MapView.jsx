import { useState, useEffect } from 'react'
import { MapContainer, TileLayer, GeoJSON } from 'react-leaflet'
import L from 'leaflet'
import api from '../config/api'
import dataDeteksi from './hasil_deteksi.json' 

function MapView() {
  const [geojsonData, setGeojsonData] = useState(null)

  // 1. Fetch Data GeoJSON dari API (Data Halte - TETAP)
  useEffect(() => {
    const fetchGeoJSON = async () => {
      try {
        const response = await api.get('/halte/geojson') 
        setGeojsonData(response.data)
      } catch (error) {
        console.error('Gagal mengambil data:', error)
      }
    }
    fetchGeoJSON()
  }, [])

  // 2. Styling Berbeda untuk Setiap Jenis Halte (TETAP)
  const getMarkerColor = (jenis) => {
    switch (jenis?.toLowerCase()) {
      case 'brt': return '#e74c3c'    
      case 'bus': return '#3498db'    
      case 'angkot': return '#2ecc71' 
      default: return '#95a5a6'       
    }
  }

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

  // 3. Popup dan Interaksi Hover untuk Halte (TETAP)
  const onEachFeature = (feature, layer) => {
    const { nama, jenis } = feature.properties
    
    layer.bindPopup(`
      <div style="font-family: Arial, sans-serif;">
        <h3 style="margin: 0 0 5px 0; color: #333;">${nama}</h3>
        <p style="margin: 0;"><b>Jenis:</b> ${jenis?.toUpperCase()}</p>
      </div>
    `)

    layer.on({
      mouseover: (e) => {
        const target = e.target
        target.setStyle({ radius: 12, weight: 3, fillOpacity: 1 })
        target.openPopup()
      },
      mouseout: (e) => {
        const target = e.target
        target.setStyle({ radius: 8, weight: 2, fillOpacity: 0.8 })
        target.closePopup()
      }
    })
  }

  return (
    <MapContainer 
      center={[-5.42, 105.26]} 
      zoom={13} 
      style={{ height: '100vh', width: '100%' }}
    >
      <TileLayer
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
      />
      
      {/* LAYER 1: Titik-titik Halte dari Database (TETAP) */}
      {geojsonData && (
        <GeoJSON 
          data={geojsonData} 
          pointToLayer={pointToLayer}
          onEachFeature={onEachFeature}
        />
      )}

      {/* 2. TAMBAHAN BARU: LAYER 2 Khusus Deteksi AI */}
      <GeoJSON 
        data={dataDeteksi} 
        onEachFeature={(feature, layer) => {
          if (feature.properties) {
            const namaObjek = feature.properties.class_name;
            const akurasi = (feature.properties.confidence * 100).toFixed(1) + '%';
            // Popup unik untuk membedakan dengan Halte
            layer.bindPopup(`
              <div style="font-family: Arial, sans-serif; text-align: center;">
                <b style="color: #8e44ad;">🤖 Deteksi Spatial AI</b><br/>
                <hr style="margin: 5px 0;"/>
                <b>Objek:</b> ${namaObjek.toUpperCase()} <br/>
                <b>Akurasi:</b> ${akurasi}
              </div>
            `);
          }
        }} 
      />

    </MapContainer>
  )
}

export default MapView