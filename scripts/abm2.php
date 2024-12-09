<?php
$host = "localhost";
$user = "root";
$password = "";
$dbname = "bd_consumo_electrico";

$conn = new mysqli($host, $user, $password, $dbname);

// Verifica la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Consulta para obtener datos
$sql = "SELECT * FROM medidor";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Medidores</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Gestión de Medidores</h1>
        <div class="d-flex justify-content-end mb-3">
            <button class="btn btn-primary me-2" onclick="location.href='agregarmed.php'">Agregar Medidor</button>
            <input type="number" id="idSeleccionado" class="form-control w-25 me-2" placeholder="ID de Medidor" />
            <button class="btn btn-warning me-2" onclick="editarMedidor()">Editar Medidor</button>
            <button class="btn btn-danger" onclick="eliminarMedidor()">Eliminar Medidor</button>
            <button class="btn btn-secondary" onclick="location.href=`http://127.0.0.1:5500/Proyecto%20Final%20IoT/interfaz%20web/index.html`">Volver</button>
        </div>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Usuario ID</th>
                    <th>Nombre</th>
                    <th>Tipo</th>
                    <th>Fecha de Registro</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        echo "<tr>
                                <td>{$row['ID']}</td>
                                <td>{$row['UsuarioID']}</td>
                                <td>{$row['Nombre']}</td>
                                <td>{$row['Tipo']}</td>
                                <td>{$row['FechaRegistro']}</td>
                            </tr>";
                    }
                } else {
                    echo "<tr><td colspan='5' class='text-center'>No hay medidores registrados</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>

    <script>
        function editarMedidor() {
            const id = document.getElementById('idSeleccionado').value;
            if (id) {
                window.location.href = `editarmed.php?id=${id}`;
            } else {
                alert("Por favor, ingrese el ID del medidor que desea editar.");
            }
        }

        function eliminarMedidor() {
            const id = document.getElementById('idSeleccionado').value;
            if (id && confirm("¿Está seguro de eliminar este medidor?")) {
                window.location.href = `eliminarmed.php?id=${id}`;
            } else if (!id) {
                alert("Por favor, ingrese el ID del medidor que desea eliminar.");
            }
        }
    </script>
</body>
</html>

<?php
$conn->close();
?>
