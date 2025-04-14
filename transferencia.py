import csv, random
if __name__ == "__main__":
    propiedad = {}
    with open("vehiculos.csv", "r") as fvehiculos:
        reader = csv.reader(fvehiculos, skipinitialspace=True, lineterminator="\n")
        for i,fila in enumerate(reader):
            try:
                propiedad[fila[-1]].append(fila[0])
            except KeyError:
                propiedad[fila[-1]] = [fila[0]]
            if i % 50000 == 0:
                print(f"{i//50000}%")
    with open("reservas_viejo.csv", "r") as fres, open("reservas.csv", "w") as fresnuevo:
        reader = csv.reader(fres, skipinitialspace=True, lineterminator="\n")
        writer = csv.writer(fresnuevo, lineterminator="\n", skipinitialspace=True)
        print("Generando listas")
        propietarios = list(propiedad.keys())
        print("Listas generadas")
        for i,fila in enumerate(reader):
            try:
                fila[3] = random.choice(propiedad[fila[-1]])
            except KeyError:
                fila[-1] = random.choice(propietarios)
                fila[3] = random.choice(propiedad[fila[-1]])
            writer.writerow(fila)
            if i % 400000 == 0:
                print(f"{i//400000}%")