----------preparacion-----------
CREATE TABLE clientes (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    rfc VARCHAR(13),
    edad INTEGER,
    ciudad VARCHAR(80),
    codigo_postal VARCHAR(10),
    fecha_alta DATE DEFAULT CURRENT_DATE
);
----------verificar que la extencion pgcrypto este disponible---------
CREATE EXTENSION IF NOT EXISTS pgcrypto;

----------comprobar------------
SELECT extname
FROM pg_extension
WHERE extname = 'pgcrypto';
------------Actividad 1 proteccion de credenciales------------
CREATE TABLE usuarios_insegura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL
);
--------------insertar un nuevo usuario------------
INSERT INTO usuarios_insegura (usuario, password)
VALUES ('juan', 'Password123');
------------consulta---------------
SELECT *
FROM usuarios_insegura;
---------7.3 Generar una representacion no reversible-------
SELECT crypt(
    'Password123',
    gen_salt('bf')
);
--------------Observar resultado------------
SELECT *
FROM usuarios_insegura;

-----------------------------7.4 Crear una tabla para credenciales protegidas-------
CREATE TABLE usuarios_segura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL
);

-------------- insertar un nuevo usuario-------------
INSERT INTO usuarios_segura (usuario, password_hash)
VALUES (
    'juan',
    crypt('Password123', gen_salt('bf'))
);
-----consulta-----
SELECT *
FROM usuarios_segura;

-------------------7.5 Verificar una contraseña---------------------
SELECT
    usuario,
    password_hash = crypt('Password123', password_hash)
        AS contraseña_correcta
FROM usuarios_segura
WHERE usuario = 'juan';

-------------------------probar contraseña incorrecta
SELECT
    usuario,
    password_hash = crypt('OtraPassword', password_hash)
        AS contraseña_correcta
FROM usuarios_segura
WHERE usuario = 'juan';

