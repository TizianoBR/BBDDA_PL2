import random
from datetime import datetime, timedelta


provincias = ['Alava','Albacete','Alicante','Almeria','Asturias','Avila','Badajoz','Barcelona','Burgos','Caceres',
'Cadiz','Cantabria','Castellon','Ciudad Real','Cordoba','La Coruña','Cuenca','Gerona','Granada','Guadalajara',
'Guipuzcoa','Huelva','Huesca','Islas Baleares','Jaen','Leon','Lerida','Lugo','Madrid','Malaga','Murcia','Navarra',
'Orense','Palencia','Las Palmas','Pontevedra','La Rioja','Salamanca','Segovia','Sevilla','Soria','Tarragona',
'Santa Cruz de Tenerife','Teruel','Toledo','Valencia','Valladolid','Vizcaya','Zamora','Zaragoza']

colores = ["Rojo", "Azul", "Verde", "Amarillo", "Blanco", "Negro", "Gris"]

def generar_matricula(numero):
    letras = "BCDFGHJKLMNPRSTVWXYZ"
    numero_matricula = str(numero % 10000).zfill(4)
    numero = numero // 10000
    letra3 = numero % 20
    numero = numero // 20
    letra2 = numero % 20
    numero = numero // 20
    letra1 = numero % 20
    return f"{numero_matricula}{letras[letra1]}{letras[letra2]}{letras[letra3]}"

def gen_fecha_rand():
    inicio = datetime(2024,1,1)
    fin = datetime(2024,12,31)
    diff = fin-inicio

    aumento_rand = random.randrange(diff.days)
    aumento_rand_horas = random.randrange(24)

    f_inicio = inicio + timedelta(days = aumento_rand) + timedelta(hours = aumento_rand_horas)

    return (f_inicio, f_inicio+timedelta(hours=random.randint(1, 240)))
def gen_clientes_csv():
    with open("clientes.csv", "w") as f:
        for i in range(1, 3000001):
            f.write(f"{i},cliente_{i},apellido_{i},cliente_{i}@example.ex,{600_000_000 + i},{random.choice(provincias)}\n")
    print("Clientes hecho")

def gen_vehiculos_csv():
    with open("vehiculos.csv", "w") as f:
        for i in range(1, 5000001):
            f.write(f"{i},{generar_matricula(i)},marca_{random.randint(1,500)},modelo_{random.randint(1,20)},{random.choice(colores)}, {random.randint(1,3000000)}\n")
    print("Vehiculos hecho")

def gen_plazas_csv():
    with open("plazas.csv", "w") as f:
        for i in range(1, 200001):
            f.write(f"{i},{i%((200000//66)+1)},{random.randint(-10,0)},{random.choice(['A','B','C','D','E','F'])}\n")
    print("Plazas hecho")

def gen_reservas_y_pagos_csv():
    with open("reservas.csv", "w") as fres:
        with open("pagos.csv", "w") as fpag:
            for i in range(1, 40_000_001):
                f_ini, f_fin = gen_fecha_rand()
                fres.write(f"{i},{f_ini.strftime('%Y-%m-%d %H:%M:%S')},{f_fin.strftime('%Y-%m-%d %H:%M:%S')},{random.randint(1,5000000)},{random.randint(1,200000)},{random.randint(1,3000000)}\n")
                f_pago = f_ini - timedelta(days = random.randint(1,10), hours = random.randint(1,23))
                fpag.write(f"{i},{3*(f_fin - f_ini).total_seconds()/3600},{f_pago.strftime('%Y-%m-%d %H:%M:%S')},{random.choice(['Efectivo', 'Tarjeta de credito', 'Tarjeta de debito', 'PayPal', 'Bizum', 'Transferencia'])},{i}\n")
                if i % 400_000 == 0:
                    print(f"{i//400_000}%")
    print("Reservas y pagos hecho")

def gen_incidencias_csv():
    with open("incidencias.csv", "w") as f:
        for i in range(1, 4000001):
            f.write(f"{i},incidencia_{i},{gen_fecha_rand()[1].strftime('%Y-%m-%d %H:%M:%S')},{random.choice(["Nueva","Abierta","En proceso","Resuelta","Cerrada"])},{random.randint(1,40000000)}\n")
    print("Incidencias hecho")

def gen_telepark():

    gen_clientes_csv()
    gen_vehiculos_csv()
    gen_plazas_csv()
    gen_reservas_y_pagos_csv()
    gen_incidencias_csv()

if __name__ == "__main__":
    #gen_telepark()
    # res = gen_fecha_rand()
    # print(res[0].strftime("%Y-%m-%d %H:%M:%S"), res[1].strftime("%Y-%m-%d %H:%M:%S"))
    gen_clientes_csv()