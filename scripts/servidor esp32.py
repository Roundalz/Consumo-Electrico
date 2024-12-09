from machine import ADC, Pin, PWM
import network
import socket
import time
import math
import json

# Configuración del LED RGB con PWM
led_red = PWM(Pin(14), freq=1000)
led_green = PWM(Pin(13), freq=1000)
led_blue = PWM(Pin(12), freq=1000)

def set_led_color(red, green, blue):
    """
    Establece el color del LED RGB usando valores PWM.
    Los valores deben estar en el rango de 0 a 1023.
    """
    led_red.duty(red)
    led_green.duty(green)
    led_blue.duty(blue)

# Función para realizar la medición
def comenzar_medicion():
    print("Procesando solicitud de medición...")
    
    # Encender LED verde para indicar que la medición ha comenzado
    set_led_color(0, 1023, 0)  # Verde

    try:
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

        # Crear un diccionario con los resultados
        datos = {
            'corriente_rms': corriente_rms,
            'voltaje_rms': voltaje_rms,
            'potencia_aparente': potencia_aparente,
            'potencia_activa': potencia_activa,
            'energia': energia
        }

        # Cambiar el LED a rojo para indicar que la medición ha finalizado
        set_led_color(1023, 0, 0)  # Rojo

        return datos

    except Exception as e:
        print("Error al realizar la medición:", e)
        set_led_color(1023, 0, 0)  # Rojo en caso de error
        return {"error": "Hubo un problema con la medición"}

# Función del servidor (sin cambios principales)
def start_server():
    sta_if = network.WLAN(network.STA_IF)
    sta_if.active(True)
    sta_if.connect('Realme 11 peluson', 'rikoricardo')
    while not sta_if.isconnected():
        time.sleep(1)
    print('Conectado a la red Wi-Fi, IP:', sta_if.ifconfig()[0])

    addr = socket.getaddrinfo('0.0.0.0', 80)[0][-1]
    s = socket.socket()
    s.bind(addr)
    s.listen(1)
    print('Escuchando en', addr)

    while True:
        cl, addr = s.accept()
        print('Cliente conectado desde', addr)

        try:
            request = cl.recv(1024).decode('utf-8')
            print("Solicitud recibida:", request)

            if 'GET /comenzar_medicion' in request:
                print('Procesando solicitud de medición...')
                medicion = comenzar_medicion()

                cl.send('HTTP/1.1 200 OK\r\n')
                cl.send('Content-Type: application/json\r\n')
                cl.send('Access-Control-Allow-Origin: *\r\n')
                cl.send('Access-Control-Allow-Headers: Content-Type\r\n')
                cl.send('Access-Control-Allow-Methods: GET\r\n')
                cl.send('\r\n')

                cl.send(json.dumps(medicion))
                print('Datos enviados:', medicion)
            else:
                cl.send('HTTP/1.1 404 Not Found\r\n')
                cl.send('Content-Type: application/json\r\n')
                cl.send('Access-Control-Allow-Origin: *\r\n')
                cl.send('\r\n')
                cl.send(json.dumps({"error": "Ruta no encontrada"}))

        except Exception as e:
            print("Error en el procesamiento de la solicitud:", e)
            cl.send('HTTP/1.1 500 Internal Server Error\r\n')
            cl.send('Content-Type: application/json\r\n')
            cl.send('Access-Control-Allow-Origin: *\r\n')
            cl.send('\r\n')
            cl.send(json.dumps({"error": "Hubo un problema con la medición"}))

        finally:
            cl.close()

# Iniciar el servidor web
start_server()