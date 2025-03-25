import random
from datetime import datetime, timedelta


provincias = ["Galicia", "Asturias", "Cantabria", "Pais Vasco", "Navarra", "La Rioja", "Aragon", "Cataluña", "Castilla y Leon", "Madrid", "Castilla la Mancha", "Extremadura", "Andalucia", "Murcia", "Valencia", "Islas Baleares", "Islas Canarias"]

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
    inicio = datetime(2005,1,1)
    fin = datetime(2025,3,25)
    diff = fin-inicio

    aumento_rand = random.randrange(diff.days)

    f_inicio = inicio + timedelta(days = aumento_rand)

    return (f_inicio.strftime('%Y-%m-%d %H:%M:%S'), (f_inicio+timedelta(days = random.randint(1,10))).strftime('%Y-%m-%d %H:%M:%S'))

def gen_telepark():
    with open("clientes.csv", "w") as f:
        for i in range(1, 3000001):
            f.write(f"{i},cliente_{i},apellido_{i},cliente_{i}@example.ex,{random.randint(10000000, 99999999)},{random.choice(provincias)}\n")
    print("Clientes hecho")
        
    with open("vehiculos.csv", "w") as f:
        for i in range(1, 5000001):
            f.write(f"{i},{generar_matricula(i)},marca_{random.randint(1,500)},modelo_{random.randint(1,20)},{random.choice(colores)}, {random.randint(1,3000000)}\n")
    print("Vehiculos hecho")

    with open("plazas.csv", "w") as f:
        for i in range(1, 200001):
            f.write(f"{i},{i%((200000//66)+1)},{random.randint(-10,0)},{random.choice(['A','B','C','D','E','F'])}\n")
    print("Plazas hecho")

    with open("reservas.csv", "w") as f:
        for i in range(1, 40000001):
            f_ini, f_fin = gen_fecha_rand()
            f.write(f"{i},{f_ini},{f_fin},{random.randint(1,5000000)},{random.randint(1,200000)},{random.randint(1,3000000)}\n")
    print("Reservas hecho")

    with open("pagos.csv", "w") as f:
        for i in range(1, 40000001):
            f.write(f"{i},{random.randint(1,9999999999)/100},{gen_fecha_rand()[0]},{random.choice(["Efectivo", "Tarjeta de credito", "Tarjeta de debito", "PayPal", "Bizzum", "Transferencia"])}\n")
    print("Pagos hecho")

    with open("incidencias.csv", "w") as f:
        for i in range(1, 4000001):
            f.write(f"{i},incidencia_{i},{gen_fecha_rand()[1]},{random.choice(["Nueva","Abierta","En proceso","Resuelta","Cerrada"])},{random.randint(1,40000000)}\n")
    print("Incidencias hecho")

if __name__ == "__main__":
    gen_telepark()