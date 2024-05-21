import requests
import pymysql
import schedule
import time
from datetime import datetime, timedelta

# Conexión a la base de datos
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='',
                             database='db_metrologic')

# Clave API para OpenWeatherMap
api_key = 'ece770ec6c37023d262247638ff468c2'

def get_weather_data(lat, lon, api_key, connection):
    url = f'https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={api_key}'
    response = requests.get(url)
    data = response.json()
    
    if response.status_code == 200:
        temp = data['main']['temp'] - 273.15
        feels_like = data['main']['feels_like'] - 273.15
        temp_min = data['main']['temp_min'] - 273.15
        temp_max = data['main']['temp_max'] - 273.15
        visibility = data.get('visibility')
        dt = data['dt']
        time_zone = data['timezone']
        city_id = data['id']
        city_name = data['name']
        cod = data['cod']
        all_clouds = data['clouds']['all']
        pressure = data['main']['pressure']
        humidity = data['main']['humidity']
        sea_level = data['main']['sea_level']
        grnd_level = data['main']['grnd_level']
        speed = data['wind']['speed']
        deg = data['wind']['deg']
        gust = data['wind'].get('gust')

        cursor = connection.cursor()
        
        # Insertar datos en la base de datos
        sql1 = f"INSERT INTO metadata (visibility, dt, timezone, city_id, city_name, timeQuery, cod) VALUES ({visibility}, {dt}, {time_zone}, {city_id}, '{city_name}', NOW() - INTERVAL 5 HOUR, {cod})"
        cursor.execute(sql1)
        connection.commit()
        metadata_id = cursor.lastrowid
    
        sql3 = f"INSERT INTO coordinates (lon, lat, id_meta) VALUES ({lon}, {lat}, {metadata_id})"
        cursor.execute(sql3)
        connection.commit()
    
        sql4 = f"INSERT INTO main_data (temp, feels_like, temp_min, temp_max, pressure, humidity, sea_level, grnd_level, id_meta) VALUES ({temp}, {feels_like}, {temp_min}, {temp_max}, {pressure}, {humidity}, {sea_level}, {grnd_level}, {metadata_id})"
        cursor.execute(sql4)
        connection.commit()
    
        sql5 = f"INSERT INTO wind (speed, deg, gust, id_meta) VALUES ({speed}, {deg}, {gust}, {metadata_id})"
        cursor.execute(sql5)
        connection.commit()
    
        print(f'Datos del clima de {city_name} insertados exitosamente.')
    else:
        print('Error al obtener los datos del clima')

# Función para obtener el clima de cada ciudad
def obtener_clima():
    # Coordenadas de las ciudades
    ciudades = [
        {'nombre': 'Medellin', 'lat': 6.2476, 'lon': 75.5658},
        {'nombre': 'Bogota', 'lat': 4.7110, 'lon': 74.0721},
        {'nombre': 'Cali', 'lat': 3.4516, 'lon': 76.5320},
        {'nombre': 'Barranquilla', 'lat': 11.0041, 'lon': 74.8070}
    ]
    
    # Procesar cada ciudad
    for ciudad in ciudades:
        get_weather_data(ciudad['lat'], ciudad['lon'], api_key, connection)

# Ejecutar la función cada 5 minutos
schedule.every(5).minutes.do(obtener_clima)

while True:
    schedule.run_pending()
    time.sleep(1)
