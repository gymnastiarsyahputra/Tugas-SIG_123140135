# WebGIS Fasilitas Transportasi Bandar Lampung - Tugas 9

Aplikasi WebGIS Full-Stack yang dibangun untuk mengelola data spasial fasilitas transportasi (Halte, BRT, dan Angkot) di wilayah Bandar Lampung. Proyek ini mengintegrasikan FastAPI sebagai backend, ReactJS sebagai frontend, dan PostGIS sebagai database spasial.

## Fitur Utama
- [cite_start]**Autentikasi JWT**: Sistem login dan register yang aman menggunakan JSON Web Token[cite: 1701].
- [cite_start]**Operasi CRUD Spasial**: Menambah, melihat, mengubah, dan menghapus data halte langsung dari antarmuka web[cite: 1424].
- [cite_start]**Peta Interaktif**: Visualisasi data GeoJSON menggunakan Leaflet dengan styling dinamis berdasarkan jenis fasilitas[cite: 1337].
- [cite_start]**Interaksi Pengguna**: Popup informasi detail dan efek hover highlight pada marker peta[cite: 1175].

## Teknologi yang Digunakan

### Backend
- [cite_start]**Framework**: FastAPI [cite: 2083]
- [cite_start]**Database**: PostgreSQL dengan ekstensi PostGIS [cite: 2087]
- [cite_start]**Library**: `asyncpg` (Database driver), `python-jose` (JWT), `passlib` (Password hashing) [cite: 2084-2086]

### Frontend
- [cite_start]**Framework**: ReactJS (Vite) [cite: 2094]
- [cite_start]**Peta**: React-Leaflet [cite: 2095]
- [cite_start]**HTTP Client**: Axios dengan Interceptors untuk token otomatis [cite: 1854]
- [cite_start]**Styling**: CSS Custom / Tailwind CSS [cite: 2097]

## Struktur Proyek
```text
.
[cite_start]├── webgis-api/          # Backend FastAPI [cite: 1474]
│   ├── app/             # Logic aplikasi
│   ├── routers/         # Endpoint API (Auth & Halte)
│   ├── utils/           # Helper (JWT & Auth)
│   └── main.py          # Entry point backend
[cite_start]├── webgis-frontend/     # Frontend React [cite: 1518]
│   ├── src/
│   │   ├── components/  # MapView, Login, dll
│   │   ├── context/     # AuthContext global state
│   │   └── config/      # Axios API instance
│   └── App.jsx
└── README.md

Cara Instalasi dan Menjalankan
1. Persiapan Database
Pastikan PostGIS sudah aktif dan buat tabel yang diperlukan:
-- Tabel Halte (Tugas 7)
-- Tabel Users (Tugas 9) [cite: 2052]
CREATE TABLE transportasi.users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

2. Menjalankan Backend
Masuk ke folder backend: cd webgis-api

Install dependencies: pip install fastapi uvicorn asyncpg python-jose[cryptography] passlib[bcrypt] python-multipart

Jalankan server: uvicorn main:app --reload

Akses dokumentasi API di: http://localhost:8000/docs 

3. Menjalankan Frontend
Masuk ke folder frontend: cd webgis-frontend
Install dependencies: npm install
Jalankan aplikasi: npm run dev
Buka di browser: http://localhost:5173

Dokumentasi Screenshot (ada pada pdf)
Halaman Login
Tampilan Peta (Setelah Login)
Popup Informasi Fasilitas
Dashboard Swagger UI