
CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    qr_code TEXT UNIQUE NOT NULL,   -- código que identifica al usuario en la máquina
    puntos INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE maquinas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ubicacion TEXT NOT NULL,
    estado TEXT CHECK(estado IN ('activa', 'inactiva', 'llena')) DEFAULT 'activa',
    capacidad_max INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE materiales (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,            -- ej: "Botella PET", "Lata de aluminio"
    puntos_otorga INTEGER NOT NULL,  -- puntos por unidad depositada
    peso_promedio_kg REAL,           -- para cálculos ecológicos
    co2_mitigado_por_unidad REAL     -- gramos de CO2 ahorrados por unidad (34 o 135 según tu doc)
);

CREATE TABLE depositos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL,
    maquina_id INTEGER NOT NULL,
    material_id INTEGER NOT NULL,
    cantidad INTEGER DEFAULT 1,
    puntos_ganados INTEGER NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (maquina_id) REFERENCES maquinas(id),
    FOREIGN KEY (material_id) REFERENCES materiales(id)
);
