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


@app.route('/actualizar_empleado/<int:id_empleado>', methods=['GET', 'POST'])
def actualizar_empleado(id_empleado):
    if 'id_usuario' not in session:
        return redirect(url_for('login'))

    id_usuario = session['id_usuario']
    ip = request.remote_addr

    puestos, _ = db.listar_puestos()
    empleado, _ = db.consultar_empleado(id_empleado)

    if request.method == 'POST':
        nuevo_documento = request.form['valor_documento']
        nuevo_nombre    = request.form['nombre']
        nuevo_puesto    = request.form['nombre_puesto']

        codigo_error = db.actualizar_empleado(id_empleado, nuevo_documento, 
                                              nuevo_nombre, nuevo_puesto, 
                                              id_usuario, ip)

        if codigo_error == 0:
            return redirect(url_for('empleados'))
        else:
            descripcion_error = db.obtener_error(codigo_error)
            return render_template('actualizar_empleado.html',
                                   empleado=empleado,
                                   puestos=puestos,
                                   error=descripcion_error)

    return render_template('actualizar_empleado.html',
                           empleado=empleado,
                           puestos=puestos,
                           error=None)



@app.route('/eliminar_empleado/<int:id_empleado>', methods=['GET', 'POST'])
def eliminar_empleado(id_empleado):
    if 'id_usuario' not in session:
        return redirect(url_for('login'))

    id_usuario = session['id_usuario']
    ip = request.remote_addr

    empleado, _ = db.consultar_empleado(id_empleado)

    if request.method == 'POST':
        confirmado = int(request.form.get('confirmado', 0))
        print(f"Eliminando: id={id_empleado}, confirmado={confirmado}, usuario={id_usuario}, ip={ip}")
    
        codigo_error = db.eliminar_empleado(id_empleado, confirmado, id_usuario, ip)
        print(f"Codigo error: {codigo_error}")
    
        return redirect(url_for('empleados'))

    # GET - registra el intento y muestra confirmacion
    db.eliminar_empleado(id_empleado, 0, id_usuario, ip)

    return render_template('eliminar_empleado.html',
                           empleado=empleado,
                           error=None)

@app.route('/consultar_empleado/<int:id_empleado>')
def consultar_empleado(id_empleado):
    if 'id_usuario' not in session:
        return redirect(url_for('login'))

    empleado, codigo_error = db.consultar_empleado(id_empleado)

    if codigo_error != 0:
        descripcion_error = db.obtener_error(codigo_error)
        return redirect(url_for('empleados'))

    return render_template('consultar_empleado.html',
                           empleado=empleado,
                           error=None)

@app.route('/movimientos/<int:id_empleado>')
def movimientos(id_empleado):
    if 'id_usuario' not in session:
        return redirect(url_for('login'))

    empleado, movimientos, codigo_error = db.listar_movimientos(id_empleado)

    if codigo_error != 0:
        descripcion_error = db.obtener_error(codigo_error)
        return redirect(url_for('empleados'))

    return render_template('movimientos.html',
                       empleado=empleado,
                       movimientos=movimientos,
                       id_empleado=id_empleado,  # ← agregar
                       error=None)

@app.route('/insertar_movimiento/<int:id_empleado>', methods=['GET', 'POST'])
def insertar_movimiento(id_empleado):
    if 'id_usuario' not in session:
        return redirect(url_for('login'))

    id_usuario = session['id_usuario']
    ip = request.remote_addr

    empleado, _, _ = db.listar_movimientos(id_empleado)  # ← cambia esto

    tipos_movimiento = [
        'Cumplir mes',
        'Bono vacacional',
        'Reversion Debito',
        'Disfrute de vacaciones',
        'Venta de vacaciones',
        'Reversion de Credito'
    ]

    if request.method == 'POST':
        nombre_tipo_movimiento = request.form['tipo_movimiento']
        monto                  = request.form['monto']
        fecha                  = request.form['fecha']

        codigo_error = db.insertar_movimiento(id_empleado, nombre_tipo_movimiento,
                                              monto, fecha, id_usuario, ip)

        if codigo_error == 0:
            return redirect(url_for('movimientos', id_empleado=id_empleado))
        else:
            descripcion_error = db.obtener_error(codigo_error)
            return render_template('insertar_movimiento.html',
                                   empleado=empleado,
                                   tipos_movimiento=tipos_movimiento,
                                   error=descripcion_error)

    return render_template('insertar_movimiento.html',
                       empleado=empleado,
                       tipos_movimiento=tipos_movimiento,
                       id_empleado=id_empleado,  # ← agregar esto
                       error=None)

@app.after_request
def no_cache(response):
    response.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    return response

if __name__ == '__main__':
    app.run(debug=True)