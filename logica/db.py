import pyodbc

# =============================================
# CONFIGURACION DE LA CONEXION
# =============================================
conexion_string = (
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=.\\SQLEXPRESS;"
    "DATABASE=ControlVacaciones;"
    "Trusted_Connection=yes;"
)

def get_conexion():
    return pyodbc.connect(conexion_string)

#aqui va la parte del login
def login(username, password, ip):
    con = get_conexion()
    cursor = con.cursor()

    # Llamamos al SP con parametros OUTPUT
    cursor.execute("""
        DECLARE @IdUsuario INT, @CodigoError INT;
        EXEC spLogin ?, ?, ?, @IdUsuario OUTPUT, @CodigoError OUTPUT;
        SELECT @IdUsuario, @CodigoError;
    """, username, password, ip)

    fila = cursor.fetchone()
    con.close()

    return fila[0], fila[1]

def logout(id_usuario, ip):
    con = get_conexion()
    cursor = con.cursor()

    cursor.execute("""
        DECLARE @CodigoError INT;
        EXEC spLogout ?, ?, @CodigoError OUTPUT;
        SELECT @CodigoError;
    """, id_usuario, ip)

    fila = cursor.fetchone()
    con.close()

    return fila[0]

def listar_empleados(filtro, id_usuario, ip):
    con = get_conexion()
    cursor = con.cursor()

    cursor.execute("""
        DECLARE @CodigoError INT;
        EXEC spListarEmpleados ?, ?, ?, @CodigoError OUTPUT;
        SELECT @CodigoError;
    """, filtro, id_usuario, ip)

    empleados = cursor.fetchall()
    
    cursor.nextset()
    codigo_error = cursor.fetchone()[0]
    
    con.close()

    return empleados, codigo_error

def listar_puestos():
    con = get_conexion()
    cursor = con.cursor()

    cursor.execute("""
        DECLARE @CodigoError INT;
        EXEC spListarPuestos @CodigoError OUTPUT;
        SELECT @CodigoError;
    """)

    puestos = cursor.fetchall()

    cursor.nextset()
    codigo_error = cursor.fetchone()[0]

    con.close()

    return puestos, codigo_error

def insertar_empleado(valor_documento, nombre, nombre_puesto, id_usuario, ip):
    con = get_conexion()
    cursor = con.cursor()

    cursor.execute("""
        DECLARE @CodigoError INT;
        EXEC spInsertarEmpleado ?, ?, ?, ?, ?, @CodigoError OUTPUT;
        SELECT @CodigoError;
    """, valor_documento, nombre, nombre_puesto, id_usuario, ip)

    cursor.nextset()
    codigo_error = cursor.fetchone()[0]

    con.close()

    return codigo_error

def actualizar_empleado(id_empleado, nuevo_documento, nuevo_nombre, nuevo_puesto, id_usuario, ip):
    con = get_conexion()
    cursor = con.cursor()

    cursor.execute("""
        DECLARE @CodigoError INT;
        EXEC spActualizarEmpleado ?, ?, ?, ?, ?, ?, @CodigoError OUTPUT;
        SELECT @CodigoError;
    """, id_empleado, nuevo_documento, nuevo_nombre, nuevo_puesto, id_usuario, ip)

    cursor.nextset()
    codigo_error = cursor.fetchone()[0]

    con.close()

    return codigo_error

def eliminar_empleado(id_empleado, confirmado, id_usuario, ip):
    con = get_conexion()
    cursor = con.cursor()

    cursor.execute("""
        DECLARE @CodigoError INT;
        EXEC spEliminarEmpleado ?, ?, ?, ?, @CodigoError OUTPUT;
        SELECT @CodigoError;
    """, id_empleado, confirmado, id_usuario, ip)

    cursor.nextset()
    codigo_error = cursor.fetchone()[0]

    con.close()

    return codigo_error

def consultar_empleado(id_empleado):
    con = get_conexion()
    cursor = con.cursor()

    cursor.execute("""
        DECLARE @CodigoError INT;
        EXEC spConsultarEmpleado ?, @CodigoError OUTPUT;
        SELECT @CodigoError;
    """, id_empleado)

    empleado = cursor.fetchone()

    cursor.nextset()
    codigo_error = cursor.fetchone()[0]

    con.close()

    return empleado, codigo_error