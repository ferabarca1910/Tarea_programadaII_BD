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

@app.route('/empleados', methods=['GET', 'POST'])
def empleados():
    if 'id_usuario' not in session:
        return redirect(url_for('login'))

    id_usuario = session['id_usuario']
    ip = request.remote_addr
    filtro = ''

    if request.method == 'POST':
        filtro = request.form.get('filtro', '')

    empleados, codigo_error = db.listar_empleados(filtro, id_usuario, ip)

    return render_template('empleados.html', 
                           empleados=empleados, 
                           filtro=filtro,
                           error=None)

@app.route('/insertar_empleado', methods=['GET', 'POST'])
def insertar_empleado():
    if 'id_usuario' not in session:
        return redirect(url_for('login'))

    id_usuario = session['id_usuario']
    ip = request.remote_addr

    puestos, _ = db.listar_puestos()

    if request.method == 'POST':
        valor_documento = request.form['valor_documento']
        nombre          = request.form['nombre']
        nombre_puesto   = request.form['nombre_puesto']

        codigo_error = db.insertar_empleado(valor_documento, nombre, nombre_puesto, id_usuario, ip)

        if codigo_error == 0:
            return redirect(url_for('empleados'))
        else:
            descripcion_error = db.obtener_error(codigo_error)
            return render_template('insertar_empleado.html', 
                                   puestos=puestos, 
                                   error=descripcion_error)

    return render_template('insertar_empleado.html', 
                           puestos=puestos, 
                           error=None)

if __name__ == '__main__':
    app.run(debug=True)