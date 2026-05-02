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