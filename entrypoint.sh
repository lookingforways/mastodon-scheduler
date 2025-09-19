#!/bin/bash
set -e # Salir inmediatamente si un comando falla

# 1. Generar la clave de encriptación
if [ ! -f /etc/mastodon-scheduler/encryption.key ]; then
    echo "Generando clave de encriptacion..."
    python3 -c 'from cryptography.fernet import Fernet; key = Fernet.generate_key(); print(key.decode())' > /etc/mastodon-scheduler/encryption.key
fi

# 2. Crear las tablas de la base de datos
python3 create_db.py

# 3. Insertar el código de invitación inicial
python3 insert_invite.py

# 4. Arrancar la aplicación
echo "Iniciando Gunicorn..."
exec gunicorn --bind 0.0.0.0:5000 app:app
