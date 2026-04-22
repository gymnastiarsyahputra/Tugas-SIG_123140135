import { createContext, useState, useContext } from 'react'
import api from '../config/api'

const AuthContext = createContext()

export function AuthProvider({ children }) {
  // Cek apakah ada token di browser saat pertama kali dimuat
  const [user, setUser] = useState(localStorage.getItem('token') ? { loggedIn: true } : null)

  const login = async (email, password) => {
    const form = new URLSearchParams()
    form.append('username', email)
    form.append('password', password)
    
    // Tembak endpoint /auth/login yang baru kita buat di FastAPI
    const res = await api.post('/auth/login', form, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    }) // <--- TAMBAHAN HEADERS ADA DI SINI
    localStorage.setItem('token', res.data.access_token)
    setUser({ loggedIn: true })
  }

  const logout = () => {
    localStorage.removeItem('token')
    setUser(null)
  }

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  )
}

export const useAuth = () => useContext(AuthContext)