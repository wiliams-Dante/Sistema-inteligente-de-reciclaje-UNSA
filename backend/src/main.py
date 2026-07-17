from fastapi import FastAPI
from src.database import get_db, init_db
import uvicorn

app = FastAPI(title="Sistema RVM Arequipa", version="1.0")

@app.on_event("startup")
def startup():
    init_db()
    print("Base de datos inicializada correctamente.")

@app.get("/")
def raiz():
    return {"mensaje": "API del Sistema Inteligente de Reciclaje funcionando 🚀"}

@app.get("/usuario/{qr_code}")
def obtener_usuario(qr_code: str):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("SELECT id, nombre, email, puntos FROM usuarios WHERE qr_code = ?", (qr_code,))
    usuario = cursor.fetchone()
    conn.close()
    if usuario is None:
        return {"error": "Usuario no encontrado"}
    return dict(usuario)

# Para ejecutar con: python -m src.main
if __name__ == "__main__":
    uvicorn.run("src.main:app", host="0.0.0.0", port=8000, reload=True)
