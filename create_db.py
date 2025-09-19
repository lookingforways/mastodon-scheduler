from app import app, db

print("Creando tablas de la base de datos...")
with app.app_context():
    db.create_all()
print("Tablas creadas con exito.")
