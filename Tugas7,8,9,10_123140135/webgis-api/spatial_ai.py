import cv2
import rasterio
import json
import numpy as np
from ultralytics import YOLO
from pyproj import Transformer

# 1. Fungsi Tiling dan Deteksi
def detect_large_image(image_path, model, tile_size=640):
    # Menggunakan Rasterio untuk membaca GeoTIFF karena lebih tangguh dari OpenCV
    with rasterio.open(image_path) as src:
        img = src.read() 
        # Rasterio membaca dengan urutan (Bands, Height, Width)
        # Kita ubah ke (Height, Width, Bands) agar bisa dibaca YOLO
        img = np.transpose(img, (1, 2, 0))
        
        # Jika gambar memiliki 4 channel (RGBA), kita ambil RGB-nya saja
        if img.shape[2] > 3:
            img = img[:, :, :3]
            
        # Jika format gambar bukan standar (misal 16-bit), kita normalkan ke 8-bit (0-255)
        if img.dtype != np.uint8:
            img = cv2.normalize(img, None, 0, 255, cv2.NORM_MINMAX, dtype=cv2.CV_8U)

    # Lanjut ke proses tiling (memotong-motong gambar)
    h, w = img.shape[:2]
    all_detections = []
    
    for y in range(0, h, tile_size):
        for x in range(0, w, tile_size):
            # Crop tile
            tile = img[y:y+tile_size, x:x+tile_size]
            
            # Skip jika tile terlalu kecil
            if tile.shape[0] < 100 or tile.shape[1] < 100:
                continue
                
            # Inference
            results = model(tile, verbose=False)
            
            # Konversi koordinat ke global
            for box in results[0].boxes:
                x1, y1, x2, y2 = box.xyxy[0].tolist()
                cls = int(box.cls[0])
                conf = float(box.conf[0])
                
                # Offset ke koordinat global
                all_detections.append({
                    'bbox': [x1+x, y1+y, x2+x, y2+y],
                    'class': cls,
                    'confidence': conf
                })
    return all_detections

# 2. Fungsi Konversi Pixel ke Geografis (Telah Diperbaiki)
def pixel_to_geo(image_path, detections):
    with rasterio.open(image_path) as src:
        transform = src.transform
        
        # Buat alat pengubah koordinat dari format bawaan gambar ke standar GPS (EPSG:4326)
        transformer = Transformer.from_crs(src.crs, "EPSG:4326", always_xy=True)
        
        geo_detections = []
        for det in detections:
            x1, y1, x2, y2 = det['bbox']
            
            # Cari titik tengah kotak deteksi
            cx = (x1 + x2) / 2
            cy = (y1 + y2) / 2
            
            # 1. Ubah pixel ke koordinat bawaan gambar (UTM)
            x_utm, y_utm = transform * (cx, cy)
            
            # 2. Ubah UTM ke Longitude/Latitude (GPS)
            lon, lat = transformer.transform(x_utm, y_utm)
            
            geo_detections.append({
                'geometry': {
                    'type': 'Point',
                    'coordinates': [lon, lat] # Sekarang nilainya pasti seperti [105.xxx, -5.yyy]
                },
                'properties': {
                    'class': det['class'],
                    'confidence': det['confidence']
                }
            })
        return geo_detections

# 3. Fungsi Export ke GeoJSON
def export_to_geojson(geo_detections, output_path):
    geojson = {
        'type': 'FeatureCollection',
        'features': []
    }
    
    # Class bawaan YOLO COCO dataset (bisa disesuaikan)
    class_names = ['person', 'bicycle', 'car', 'motorcycle', 'airplane', 'bus', 'train', 'truck', 'boat'] 
    
    for det in geo_detections:
        class_id = det['properties']['class']
        class_name = class_names[class_id] if class_id < len(class_names) else f"object_{class_id}"
        
        feature = {
            'type': 'Feature',
            'geometry': det['geometry'],
            'properties': {
                'class_id': class_id,
                'class_name': class_name,
                'confidence': round(det['properties']['confidence'], 3) #
            }
        }
        geojson['features'].append(feature)
        
    with open(output_path, 'w') as f:
        json.dump(geojson, f, indent=2) #
    print(f"Berhasil export {len(geo_detections)} deteksi ke {output_path}!")

# === CARA MENJALANKAN ===
if __name__ == "__main__":
    # Load model YOLOv8 Nano
    model = YOLO('yolov8n.pt') 
    
    # GANTI INI DENGAN NAMA FILE CITRA KAMU
    image_path = 'citra_satelit.tif' 
    
    print("Mulai mendeteksi objek...")
    pixel_detections = detect_large_image(image_path, model)
    
    print("Mengonversi koordinat ke format geografis...")
    geo_detections = pixel_to_geo(image_path, pixel_detections)
    
    print("Menyimpan hasil...")
    export_to_geojson(geo_detections, 'hasil_deteksi.geojson')