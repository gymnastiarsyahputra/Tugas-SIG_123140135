from fastapi import FastAPI
from contextlib import asynccontextmanager
from database import get_pool, close_pool
from routers import halte
from fastapi.middleware.cors import CORSMiddleware

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: Buka koneksi database
    await get_pool()
    print("Database connected")
    yield
    # Shutdown: Tutup koneksi database
    await close_pool()
    print("Database disconnected")

app = FastAPI(
    title="WebGIS API Transportasi",
    description="API untuk mengelola data spasial Halte",
    version="1.0.0",
    lifespan=lifespan
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # Mengizinkan React di port 5173 untuk mengambil data
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mendaftarkan router dari file routers/halte.py
app.include_router(halte.router)