import os
from datetime import datetime, timedelta

# El modelo InviteCode está dentro de app.py, por lo que lo importamos desde allí
from app import app, db, InviteCode

print("Intentando insertar codigo de invitacion...")
invite_code_str = os.environ.get('INVITE_CODE')

if invite_code_str:
    with app.app_context():
        # Comprueba si el código ya existe para no duplicarlo
        existing_code = db.session.query(InviteCode).filter_by(code=invite_code_str).first()
        if not existing_code:
            print(f"Insertando nuevo codigo de invitacion: {invite_code_str}")
            new_code = InviteCode(
                code=invite_code_str,
                expiration_date=datetime.utcnow() + timedelta(days=365),
                used=False
            )
            db.session.add(new_code)
            db.session.commit()
            print("Codigo de invitacion insertado con exito.")
        else:
            print("El codigo de invitacion ya existe en la base de datos.")
else:
    print("La variable de entorno INVITE_CODE no esta definida. No se insertara ningun codigo.")
