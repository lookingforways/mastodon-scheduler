# 1. Usar una imagen oficial de Python como base
FROM python:3.10-slim

# 2. Establecer el directorio de trabajo
WORKDIR /app

# 3. Crear el directorio para la clave de encriptación
RUN mkdir -p /etc/mastodon-scheduler/

# 4. Copiar todo el código de la app y nuestros scripts de arranque
COPY . .

# 5. Instalar TODAS las dependencias
RUN pip install gunicorn Flask Mastodon.py python-dotenv APScheduler pytz flask_wtf flask_sqlalchemy cryptography

# 6. Dar permisos de ejecución al script de arranque
RUN chmod +x /app/entrypoint.sh

# 7. Exponer el puerto
EXPOSE 5000

# 8. Establecer el script de arranque como el punto de entrada
ENTRYPOINT ["/app/entrypoint.sh"]
