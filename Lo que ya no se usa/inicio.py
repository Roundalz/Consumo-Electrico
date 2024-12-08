from machine import Pin, ADC
import time
import math
import urequests as requests
import ujson
import utime
from secrets import secrets  # Archivo separado para las credenciales Wi-Fi
from Wifi_lib import wifi_init, get_html  # Librerías externas

# URL del servidor PHP
url = "http://192.168.0.9/ManejoBaseDeDatos.php"
wifi_init()

# Función para registrar un usuario
def registrar_usuario(nombre, direccion, telefono, email):
    data = {
        "action": "register",
        "Nombre": nombre,
        "Direccion": direccion,
        "Telefono": telefono,
        "Email": email
    }
    print("Datos enviados:", data)  # Depuración

    try:
        response = requests.post(url, data=ujson.dumps(data), headers={"Content-Type": "application/json"})
        result = response.json()
        response.close()
        if result.get("status") == "success":
            print("Usuario registrado con éxito. ID del usuario:", result.get("userID"))
            return result.get("userID")
        else:
            print("Error en el registro:", result.get("message", "Error desconocido"))
            return None
    except Exception as e:
        print("Error al registrar usuario:", e)
        return None

# Función para iniciar sesión
def iniciar_sesion(email):
    data = {"action": "login", "Email": email}
    try:
        response = requests.post(url, data=ujson.dumps(data), headers={"Content-Type": "application/json"})
        result = response.json()
        response.close()
        if result.get("status") == "success":
            print("Inicio de sesión exitoso. Datos del usuario:", result.get("user"))
            return result.get("user").get("ID")
        else:
            print("Error al iniciar sesión:", result.get("message", "Usuario no encontrado"))
            return None
    except Exception as e:
        print("Error al iniciar sesión:", e)
        return None

# Función para agregar un nuevo medidor
def agregar_medidor(usuario_id, nombre, tipo):
    data = {
        "action": "add_medidor",
        "UsuarioID": usuario_id,
        "Nombre": nombre,
        "Tipo": tipo
    }
    try:
        response = requests.post(url, data=ujson.dumps(data), headers={"Content-Type": "application/json"})
        result = response.json()
        response.close()
        if result.get("status") == "success":
            print("Medidor agregado con éxito. ID del medidor:", result.get("medidorID"))
            return result.get("medidorID")
        else:
            print("Error al agregar medidor:", result.get("message", "Error desconocido"))
            return None
    except Exception as e:
        print("Error al agregar medidor:", e)
        return None

def obtener_medidores(usuario_id):
    data = {
    "action": "get_medidores",
    "UsuarioID": usuario_id
    }
    try:
        response = requests.post(url, data=ujson.dumps(data), headers={"Content-Type": "application/json"})
        try:
            result = response.json()
        except ValueError as e:
            print("Error al parsear JSON:", e)
            return []
        response.close()
        if result.get("status") == "success":
            return result.get("medidores", [])
        else:
            print("Error al obtener medidores:", result.get("message", "Error desconocido"))
            return []
    except Exception as e:
        print("Error al obtener medidores:", e)
        return []
    
def leer_medidor():
    # Configuración del sensor ACS712
    analog_pin = 34
    adc = ADC(Pin(analog_pin))
    adc.atten(ADC.ATTN_11DB)
    adc.width(ADC.WIDTH_12BIT)
    sensitivity = 0.066
    VCC = 5
    V_ZERO = 3.75  # Ajustar o calibrar dinámicamente

    # Cálculo de corriente RMS
    def calcular_corriente_rms(samples=1250, sampling_time=0.001):
        sum_of_squares = 0
        for _ in range(samples):
            raw_value = adc.read()
            voltage = (raw_value / 4095) * VCC
            current = (voltage - V_ZERO) / sensitivity
            sum_of_squares += current ** 2
            time.sleep(sampling_time)
        return math.sqrt(sum_of_squares / samples)

    # Cálculo de corriente RMS
    corriente_rms = calcular_corriente_rms()

    # Datos de la medición
    voltaje_rms = 220.0  # Puedes ajustar esto según tu sistema
    potencia_aparente = voltaje_rms * corriente_rms
    potencia_activa = potencia_aparente * 0.85  # Factor de potencia
    energia = potencia_activa * (1 / 3600)  # Energía en kWh

    # Retornar los valores calculados
    return corriente_rms, voltaje_rms, potencia_activa, potencia_aparente, energia

# Función para guardar la medición en la base de datos
def guardar_medicion(medidor_id, corriente_rms, voltaje_rms, potencia_activa, potencia_aparente, energia):
    data = {
        "action": "add_lectura",  # Acción que indica que es una lectura de medidor
        "MedidorID": medidor_id,  # ID del medidor
        "Corriente_rms": corriente_rms,  # Corriente RMS calculada
        "Voltaje_rms": voltaje_rms,  # Voltaje RMS
        "Potencia_activa": potencia_activa,  # Potencia activa calculada
        "Potencia_aparente": potencia_aparente,  # Potencia aparente calculada
        "Energia": energia,  # Energía calculada
    }

    # Enviar los datos al servidor
    headers = {'Content-Type': 'application/json'}
    try:
        response = requests.post(url, data=ujson.dumps(data), headers=headers)
        result = response.json()
        response.close()
        if result.get("status") == "success":
            print("Medición guardada exitosamente.")
        else:
            print("Error al guardar medición:", result.get("message", "Error desconocido"))
    except Exception as e:
        print("Error al guardar medición:", e)
        
# Función para comenzar la medición
def comenzar_medicion(medidor_id):
    # Llamar a la función leer_medidor que devuelve los valores calculados
    corriente_rms, voltaje_rms, potencia_activa, potencia_aparente, energia = leer_medidor()

    # Enviar los datos de la medición al servidor para ser guardados
    guardar_medicion(medidor_id, corriente_rms, voltaje_rms, potencia_activa, potencia_aparente, energia)

# Función para comenzar la medición constante
def comenzar_medicion_constante(medidor_id):
    
    # Ciclo infinito que realiza mediciones cada 10 segundos
    while True:
        corriente_rms, voltaje_rms, potencia_activa, potencia_aparente, energia = leer_medidor()

        # Mostrar los resultados de la medición
        print(f"Corriente RMS: {corriente_rms:.2f} A")
        print(f"Voltaje RMS: {voltaje_rms:.2f} V")
        print(f"Potencia Activa: {potencia_activa:.2f} W")
        print(f"Potencia Aparente: {potencia_aparente:.2f} VA")
        print(f"Energía: {energia:.4f} kWh")
        
        # Guardar la medición en la base de datos
        guardar_medicion(medidor_id, corriente_rms, voltaje_rms, potencia_activa, potencia_aparente, energia)

        # Esperar 10 segundos antes de la siguiente medición
        time.sleep(10)

        

def menu_medidor(usuario_id):
    medidores = obtener_medidores(usuario_id)
    if not medidores:
        print("No tiene medidores registrados.")
        if input("¿Desea agregar un nuevo medidor? (s/n): ").lower() == 's':
            nombre = input("Ingrese el nombre del medidor: ")
            tipo = input("Ingrese el tipo del medidor (por ejemplo, residencial): ")
            agregar_medidor(usuario_id, nombre, tipo)
        return

    print("\nMedidores registrados:")
    for i, medidor in enumerate(medidores):
        print(f"{i + 1}. {medidor['Nombre']} (ID: {medidor['ID']})")

    opcion = int(input("Seleccione un medidor (número): ")) - 1
    if 0 <= opcion < len(medidores):
        medidor_id = medidores[opcion]['ID']
        print(f"Medidor seleccionado: {medidores[opcion]['Nombre']}")

        while True:
            print("\n1. Comenzar medición")
            print("2. Volver al menú principal")
            opcion = input("Opción: ")

            if opcion == "1":
                comenzar_medicion_constante(medidor_id)

            elif opcion == "2":
                break
            else:
                print("Opción no válida. Intente nuevamente.")

# Función para mostrar menú de opciones
def menu(usuario_id):
    while True:
        print("\nSeleccione una opción:")
        print("1. Agregar un nuevo medidor")
        print("2. Salir")
        opcion = input("Opción: ")

        if opcion == "1":
            nombre = input("Ingrese el nombre del medidor: ")
            tipo = input("Ingrese el tipo del medidor (por ejemplo, ACS712-30A): ")
            agregar_medidor(usuario_id, nombre, tipo)
        elif opcion == "2":
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida. Intente nuevamente.")

# Programa principal
def main():
    print("Bienvenido al sistema de gestión de medidores.")
    print("Seleccione una opción:")
    print("1. Registrar nuevo usuario")
    print("2. Iniciar sesión")
    opcion = input("Opción: ")

    if opcion == "1":
        nombre = input("Ingrese su nombre: ")
        direccion = input("Ingrese su dirección: ")
        telefono = input("Ingrese su teléfono: ")
        email = input("Ingrese su correo electrónico: ")
        usuario_id = registrar_usuario(nombre, direccion, telefono, email)
        if usuario_id:
            print("Inicie sesión con su nuevo usuario.")
    elif opcion == "2":
        email = input("Ingrese su correo electrónico: ")
        usuario_id = iniciar_sesion(email)
        if usuario_id:
            print(f"Bienvenido, usuario ID: {usuario_id}")
            menu_medidor(usuario_id)
    else:
        print("Opción no válida. Reinicie el programa.")

if __name__ == "__main__":
    main()
