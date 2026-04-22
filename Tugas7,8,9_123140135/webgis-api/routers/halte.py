import json
from fastapi import APIRouter, HTTPException
from database import get_pool
from models import HalteCreate
from utils.auth import get_current_user
from fastapi import Depends

router = APIRouter(
    prefix="/api/halte",
    tags=["Halte"]
)

# 1. GET ALL
@router.get("/")
async def get_all_halte():
    pool = await get_pool()
    async with pool.acquire() as conn:
        rows = await conn.fetch("""
            SELECT id, nama, jenis, alamat, 
                   ST_X(geom) as longitude, ST_Y(geom) as latitude 
            FROM transportasi.halte 
            WHERE aktif = TRUE LIMIT 100
        """)
        return [dict(row) for row in rows]

# 2. GET GEOJSON (Format output GeoJSON)
@router.get("/geojson")
async def get_halte_geojson():
    pool = await get_pool()
    async with pool.acquire() as conn:
        rows = await conn.fetch("""
            SELECT id, nama, jenis, ST_AsGeoJSON(geom) as geom 
            FROM transportasi.halte WHERE aktif = TRUE
        """)
        features = []
        for row in rows:
            features.append({
                "type": "Feature",
                "geometry": json.loads(row["geom"]),
                "properties": {
                    "id": row["id"],
                    "nama": row["nama"],
                    "jenis": row["jenis"]
                }
            })
        return {"type": "FeatureCollection", "features": features}

# 3. GET NEARBY (Query Spasial K-NN / DWithin)
@router.get("/nearby")
async def get_nearby(lat: float, lon: float, radius: int = 1000):
    pool = await get_pool()
    async with pool.acquire() as conn:
        rows = await conn.fetch("""
            SELECT id, nama, jenis, 
                   ROUND(ST_Distance(geom::geography, ST_Point($1,$2)::geography)::numeric) as jarak_m
            FROM transportasi.halte
            WHERE ST_DWithin(geom::geography, ST_Point($1,$2)::geography, $3)
            AND aktif = TRUE
            ORDER BY jarak_m
        """, lon, lat, radius)
        return [dict(row) for row in rows]

# 4. GET BY ID
@router.get("/{id}")
async def get_halte_by_id(id: int):
    pool = await get_pool()
    async with pool.acquire() as conn:
        row = await conn.fetchrow("""
            SELECT id, nama, jenis, alamat, 
                   ST_X(geom) as longitude, ST_Y(geom) as latitude 
            FROM transportasi.halte WHERE id = $1
        """, id)
        if not row:
            raise HTTPException(status_code=404, detail="Halte tidak ditemukan")
        return dict(row)

# 5. POST (Input Data Spasial)
@router.post("/", status_code=201)
async def create_halte(data: HalteCreate, current_user: str = Depends(get_current_user)):
    pool = await get_pool()
    async with pool.acquire() as conn:
        row = await conn.fetchrow("""
            INSERT INTO transportasi.halte (nama, jenis, alamat, geom, aktif)
            VALUES ($1, $2, $3, ST_SetSRID(ST_Point($4,$5), 4326), TRUE)
            RETURNING id, nama, jenis, alamat
        """, data.nama, data.jenis, data.alamat, data.longitude, data.latitude)
        return dict(row)
    
# TAMBAHKAN endpoint PUT (Update):
@router.put("/{id}")
async def update_halte(id: int, data: HalteCreate, current_user: str = Depends(get_current_user)):
    pool = await get_pool()
    async with pool.acquire() as conn:
        row = await conn.fetchrow("""
            UPDATE transportasi.halte SET
            nama = $2, jenis = $3, alamat = $4,
            geom = ST_SetSRID(ST_Point($5,$6), 4326)
            WHERE id = $1
            RETURNING id, nama, jenis
        """, id, data.nama, data.jenis, data.alamat, data.longitude, data.latitude)
        if not row:
            raise HTTPException(status_code=404, detail="Halte tidak ditemukan")
        return dict(row)
    
# TAMBAHKAN endpoint DELETE:
@router.delete("/{id}", status_code=204)
async def delete_halte(id: int, current_user: str = Depends(get_current_user)):
    pool = await get_pool()
    async with pool.acquire() as conn:
        result = await conn.execute("DELETE FROM transportasi.halte WHERE id = $1", id)
        if result == "DELETE 0":
            raise HTTPException(status_code=404, detail="Halte tidak ditemukan")