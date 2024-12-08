from machine import Pin, ADC
import time
import math
import ujson
import urequests as requests
from Wifi_lib import wifi_init, get_html  # Librerías externas

# Configuración de Wi-Fi
if wifi_init():
    print("Conexión Wi-Fi exitosa")
else:
    print("Error al conectar a Wi-Fi")

# Configuración del sensor ACS712
analog_pin = 34
adc = ADC(Pin(analog_pin))
adc.atten(ADC.ATTN_11DB)
adc.width(ADC.WIDTH_12BIT)
sensitivity = 0.066
VCC = 5
V_ZERO = 3.75  # Ajustar o calibrar dinámicamente

# URL del servidor
url = "http://192.168.0.9/ManejoBaseDeDatos.php"

# Cálculo de corriente RMS
def calcular_corriente_rms(samples=1250, sampling_time=0.0008):
    sum_of_squares = 0
    for _ in range(samples):
        raw_value = adc.read()
        voltage = (raw_value / 4095) * VCC
        current = (voltage - V_ZERO) / sensitivity
        sum_of_squares += current ** 2
        time.sleep(sampling_time)
    return math.sqrt(sum_of_squares / samples)

# Enviar datos al servidor
def enviar_datos(url, data, headers):
    intentos = 3
    for intento in range(intentos):
        try:
            response = requests.post(url, data=ujson.dumps(data), headers=headers)
            if response.status_code == 200:
                print("Datos enviados:", data)
                print("Respuesta del servidor:", response.text)
                response.close()
                return True
            else:
                print("Error en la respuesta del servidor:", response.status_code)
        except Exception as e:
            print(f"Error en el envío (intento {intento+1}/{intentos}):", e)
            time.sleep(5)
    return False

# Bucle principal
while True:
    try:
        corriente_rms = calcular_corriente_rms()
        voltaje_rms = 220.0
        potencia_aparente = voltaje_rms * corriente_rms
        potencia_activa = potencia_aparente * 0.85
        energia = potencia_activa * (1 / 3600)

        data = {
            "action": "add_lectura",
            "MedidorID": 6,
            "Corriente_rms": corriente_rms,
            "Voltaje_rms": voltaje_rms,
            "Potencia_activa": potencia_activa,
            "Potencia_aparente": potencia_aparente,
            "Energia": energia,
        }

        headers = {'Content-Type': 'application/json'}
        enviar_datos(url, data, headers)

    except Exception as e:
        print("Error en la ejecución:", e)
        time.sleep(5)

    time.sleep(10)
