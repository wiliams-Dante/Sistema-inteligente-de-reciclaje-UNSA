import sqlite3
import os

DATABASE_PATH = os.path.join(os.path.dirname(__file__), "..", "rvm.db")  # El archivo .db se creará en backend/
SCHEMA_PATH = os.path.join(os.path.dirname(__file__), "..", "..", "database", "schema.sql")
SEED_PATH = os.path.join(os.path.dirname(__file__), "..", "..", "database", "seed.sql")

def get_db():
    """Devuelve una conexión a la base de datos."""
    conn = sqlite3.connect(DATABASE_PATH)
    conn.row_factory = sqlite3.Row  # Para acceder a columnas por nombre
    conn.execute("PRAGMA foreign_keys = ON")
    return conn

def init_db():
    """Crea las tablas y carga los datos de prueba si no existen."""
    conn = get_db()
    cursor = conn.cursor()
    
    # Ejecutar schema.sql si la tabla 'usuarios' no existe (evita duplicados)
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='usuarios'")
    if cursor.fetchone() is None:
        with open(SCHEMA_PATH, "r") as f:
            conn.executescript(f.read())
    
    # Ejecutar seed.sql si la tabla 'materiales' está vacía
    cursor.execute("SELECT COUNT(*) FROM materiales")
    if cursor.fetchone()[0] == 0:
        with open(SEED_PATH, "r") as f:
            conn.executescript(f.read())
    
    conn.commit()
    conn.close()
