from flask import Flask, render_template, request, redirect, url_for, session
import db

# =============================================
# CONFIGURACION DE FLASK
# =============================================
app = Flask(__name__, template_folder='../presentacion/templates', 
                       static_folder='../presentacion/static')

app.secret_key = 'clave_secreta_tarea_bd1'

# =============================================
# RUTAS
# =============================================
@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        ip = request.remote_addr

        id_usuario, codigo_error = db.login(username, password, ip)

        if codigo_error == 0:
            session['id_usuario'] = id_usuario
            session['username'] = username
            return redirect(url_for('empleados'))
        else:
            descripcion_error = db.obtener_error(codigo_error)
            return render_template('login.html', error=descripcion_error)

    return render_template('login.html', error=None)

@app.route('/logout')
def logout(): 
    ip = request.remote_addr
    id_usuario = session.get('id_usuario', 1)

    db.logout(id_usuario, ip)

    session.clear()
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)