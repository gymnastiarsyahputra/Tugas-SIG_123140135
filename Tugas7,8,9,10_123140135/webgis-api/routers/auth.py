from fastapi import APIRouter, HTTPException, Depends
from fastapi.security import OAuth2PasswordRequestForm
from pydantic import BaseModel
from database import get_pool
from utils.auth import verify_password, get_password_hash, create_access_token

router = APIRouter(prefix="/api/auth", tags=["Auth"])

class UserCreate(BaseModel):
    email: str
    password: str

@router.post("/register")
async def register(user: UserCreate):
    pool = await get_pool()
    hashed_password = get_password_hash(user.password)
    async with pool.acquire() as conn:
        try:
            await conn.execute(
                "INSERT INTO transportasi.users (email, password_hash) VALUES ($1, $2)",
                user.email, hashed_password
            )
            return {"message": "User berhasil didaftarkan"}
        except Exception:
            raise HTTPException(status_code=400, detail="Email sudah terdaftar")

@router.post("/login")
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    pool = await get_pool()
    async with pool.acquire() as conn:
        user = await conn.fetchrow(
            "SELECT * FROM transportasi.users WHERE email = $1", form_data.username
        )
        if not user or not verify_password(form_data.password, user["password_hash"]):
            raise HTTPException(status_code=401, detail="Email atau password salah")
        
        access_token = create_access_token(data={"sub": user["email"]})
        return {"access_token": access_token, "token_type": "bearer"}