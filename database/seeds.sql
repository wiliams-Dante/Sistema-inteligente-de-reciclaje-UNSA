
INSERT INTO materiales (nombre, puntos_otorga, peso_promedio_kg, co2_mitigado_por_unidad)
VALUES 
  ('Botella PET', 10, 0.02, 34),
  ('Lata de aluminio', 15, 0.015, 135);

INSERT INTO usuarios (nombre, email, qr_code, puntos)
VALUES ('Paula Tamayo', 'paula@email.com', 'QR001', 0);

INSERT INTO maquinas (ubicacion, estado, capacidad_max)
VALUES ('Parque Selva Alegre - Arequipa', 'activa', 500);

INSERT INTO depositos (usuario_id, maquina_id, material_id, cantidad, puntos_ganados)
VALUES 
  (1, 1, 1, 1, 10),   -- 1 botella PET → 10 puntos
  (1, 1, 2, 1, 15);   -- 1 lata de aluminio → 15 puntos
