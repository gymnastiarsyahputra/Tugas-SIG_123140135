# WebGIS Fasilitas Transportasi & Spatial AI 🛰️📍

Sistem Informasi Geografis (SIG) Full-Stack yang mengintegrasikan pengelolaan data spasial transportasi publik (Halte, Rute BRT, Angkot) dengan teknologi Kecerdasan Buatan Spasial (*Spatial AI*) untuk deteksi objek udara secara otomatis.

Proyek ini dikembangkan sebagai pemenuhan Tugas Terintegrasi (Tugas 7 - 10) Mata Kuliah Sistem Informasi Geografis di Program Studi Teknik Informatika, Institut Teknologi Sumatera (ITERA).

---

## 🚀 Perjalanan Proyek (Tugas 7 - 10)

Proyek ini dibangun secara bertahap dengan pencapaian sebagai berikut:

*   **Tugas 7 & 8: Spatial Backend & Database**
    *   Membangun struktur *database* spasial menggunakan PostgreSQL dan ekstensi PostGIS.
    *   Mengembangkan RESTful API menggunakan FastAPI untuk operasi CRUD data spasial (Titik Halte).
*   **Tugas 9: Frontend & Authentication (Full-Stack)**
    *   Membangun antarmuka pengguna interaktif menggunakan ReactJS (Vite) dan React-Leaflet.
    *   Menerapkan sistem keamanan Autentikasi menggunakan JSON Web Token (JWT) dan *password hashing* (`bcrypt`) untuk halaman Login dan Register.
*   **Tugas 10: Spatial AI & Computer Vision**
    *   Mengimplementasikan model **YOLOv8** untuk mendeteksi objek secara otomatis pada citra satelit/udara berformat GeoTIFF.
    *   Menggunakan teknik *Image Tiling* (memotong citra besar) agar model AI tidak kehabisan memori.
    *   Melakukan georeferensi untuk mengubah koordinat *pixel* (gambar) menjadi koordinat bumi nyata (Longitude/Latitude EPSG:4326).
    *   Menyatukan (*overlay*) hasil deteksi AI berbentuk file GeoJSON langsung ke atas peta WebGIS.

---

## 🛠️ Teknologi yang Digunakan

**Frontend:**
*   ReactJS (Vite)
*   React-Leaflet (Peta Web Interaktif)
*   Axios (HTTP Client)

**Backend & Database:**
*   Python (FastAPI, Uvicorn)
*   PostgreSQL + PostGIS (Penyimpanan Spasial)
*   Python-JOSE & Passlib (Keamanan Autentikasi)

**Computer Vision & Spatial AI:**
*   Ultralytics (Model AI YOLOv8)
*   OpenCV & Numpy (Image Processing)
*   Rasterio & PyProj (Geospatial Data & Coordinate Transformation)

---

## 📁 Struktur Repositori
```text
📦 webgis-project-itera
 ┣ 📂 webgis-api/           # Backend FastAPI & Script Spatial AI
 ┃ ┣ 📂 routers/            # Endpoint API (Auth, Halte)
 ┃ ┣ 📜 spatial_ai.py       # Pipeline AI (Tiling, Deteksi, Georef)
 ┃ ┣ 📜 citra_satelit.tif   # Citra input (GeoTIFF)
 ┃ ┣ 📜 hasil_deteksi.json  # Output GeoJSON dari Spatial AI
 ┃ ┗ 📜 main.py             # Entry point API
 ┣ 📂 webgis-frontend/      # Frontend ReactJS
 ┃ ┣ 📂 src/
 ┃ ┃ ┣ 📂 components/       # MapView.jsx, Login.jsx
 ┃ ┃ ┣ 📂 context/          # AuthContext (State Management)
 ┃ ┃ ┗ 📜 App.jsx
 ┃ ┗ 📜 package.json
 ┗ 📜 README.md             # Dokumentasi Proyek

 💻 Cara Instalasi & Menjalankan
1. Menyiapkan Database PostGIS
Pastikan server PostgreSQL berjalan, ekstensi postgis aktif, dan table users serta halte sudah terkonfigurasi sesuai skema.

2. Menjalankan Backend API
cd webgis-api
# Install dependencies utama dan AI
pip install fastapi uvicorn asyncpg python-jose[cryptography] passlib[bcrypt] ultralytics opencv-python rasterio pyproj
# Jalankan server
uvicorn main:app --reload
API Dokumentasi dapat diakses pada: http://localhost:8000/docs

Tentu, Zans! Menggabungkan keseluruhan progres dari Tugas 7 hingga Tugas 10 ke dalam satu README.md utama adalah langkah yang brilian. Ini akan membuat repositori GitHub-mu terlihat sangat profesional dan menunjukkan perjalanan panjangmu membangun aplikasi Full-Stack berbasis Spatial AI.

Kamu bisa membuat/mengganti file README.md di luar folder proyek (sejajar dengan folder webgis-api dan webgis-frontend) dengan konten Markdown berikut:

Markdown
# WebGIS Fasilitas Transportasi & Spatial AI 🛰️📍

Sistem Informasi Geografis (SIG) Full-Stack yang mengintegrasikan pengelolaan data spasial transportasi publik (Halte, Rute BRT, Angkot) dengan teknologi Kecerdasan Buatan Spasial (*Spatial AI*) untuk deteksi objek udara secara otomatis.

Proyek ini dikembangkan sebagai pemenuhan Tugas Terintegrasi (Tugas 7 - 10) Mata Kuliah Sistem Informasi Geografis di Program Studi Teknik Informatika, Institut Teknologi Sumatera (ITERA).

---

## 🚀 Perjalanan Proyek (Tugas 7 - 10)

Proyek ini dibangun secara bertahap dengan pencapaian sebagai berikut:

*   **Tugas 7 & 8: Spatial Backend & Database**
    *   Membangun struktur *database* spasial menggunakan PostgreSQL dan ekstensi PostGIS.
    *   Mengembangkan RESTful API menggunakan FastAPI untuk operasi CRUD data spasial (Titik Halte).
*   **Tugas 9: Frontend & Authentication (Full-Stack)**
    *   Membangun antarmuka pengguna interaktif menggunakan ReactJS (Vite) dan React-Leaflet.
    *   Menerapkan sistem keamanan Autentikasi menggunakan JSON Web Token (JWT) dan *password hashing* (`bcrypt`) untuk halaman Login dan Register.
*   **Tugas 10: Spatial AI & Computer Vision**
    *   Mengimplementasikan model **YOLOv8** untuk mendeteksi objek secara otomatis pada citra satelit/udara berformat GeoTIFF.
    *   Menggunakan teknik *Image Tiling* (memotong citra besar) agar model AI tidak kehabisan memori.
    *   Melakukan georeferensi untuk mengubah koordinat *pixel* (gambar) menjadi koordinat bumi nyata (Longitude/Latitude EPSG:4326).
    *   Menyatukan (*overlay*) hasil deteksi AI berbentuk file GeoJSON langsung ke atas peta WebGIS.

---

## 🛠️ Teknologi yang Digunakan

**Frontend:**
*   ReactJS (Vite)
*   React-Leaflet (Peta Web Interaktif)
*   Axios (HTTP Client)

**Backend & Database:**
*   Python (FastAPI, Uvicorn)
*   PostgreSQL + PostGIS (Penyimpanan Spasial)
*   Python-JOSE & Passlib (Keamanan Autentikasi)

**Computer Vision & Spatial AI:**
*   Ultralytics (Model AI YOLOv8)
*   OpenCV & Numpy (Image Processing)
*   Rasterio & PyProj (Geospatial Data & Coordinate Transformation)

---

## 📁 Struktur Repositori
```text
📦 webgis-project-itera
 ┣ 📂 webgis-api/           # Backend FastAPI & Script Spatial AI
 ┃ ┣ 📂 routers/            # Endpoint API (Auth, Halte)
 ┃ ┣ 📜 spatial_ai.py       # Pipeline AI (Tiling, Deteksi, Georef)
 ┃ ┣ 📜 citra_satelit.tif   # Citra input (GeoTIFF)
 ┃ ┣ 📜 hasil_deteksi.json  # Output GeoJSON dari Spatial AI
 ┃ ┗ 📜 main.py             # Entry point API
 ┣ 📂 webgis-frontend/      # Frontend ReactJS
 ┃ ┣ 📂 src/
 ┃ ┃ ┣ 📂 components/       # MapView.jsx, Login.jsx
 ┃ ┃ ┣ 📂 context/          # AuthContext (State Management)
 ┃ ┃ ┗ 📜 App.jsx
 ┃ ┗ 📜 package.json
 ┗ 📜 README.md             # Dokumentasi Proyek
💻 Cara Instalasi & Menjalankan
1. Menyiapkan Database PostGIS
Pastikan server PostgreSQL berjalan, ekstensi postgis aktif, dan table users serta halte sudah terkonfigurasi sesuai skema.

2. Menjalankan Backend API
Bash
cd webgis-api
# Install dependencies utama dan AI
pip install fastapi uvicorn asyncpg python-jose[cryptography] passlib[bcrypt] ultralytics opencv-python rasterio pyproj
# Jalankan server
uvicorn main:app --reload
API Dokumentasi dapat diakses pada: http://localhost:8000/docs

3. Menjalankan Pipeline Spatial AI
Bash
cd webgis-api
# Pastikan ada file citra satelit (GeoTIFF) bernama 'citra_satelit.tif' di dalam folder
python spatial_ai.py
Script ini akan memproses citra dan menghasilkan file hasil_deteksi.json yang secara otomatis dipanggil oleh Frontend.

4. Menjalankan Frontend
Bash
cd webgis-frontend
npm install
npm run dev
Buka http://localhost:5173 di browser. Login menggunakan akun yang sudah dibuat via Swagger UI untuk melihat peta dan hasil deteksi AI.