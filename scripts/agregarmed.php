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

// Verificar si se ha enviado el formulario
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuarioId = $_POST['usuario_id'];
    $nombre = $_POST['nombre'];
    $tipo = $_POST['tipo'];

    $sql = "INSERT INTO medidor (UsuarioID, Nombre, Tipo, FechaRegistro) VALUES ('$usuarioId', '$nombre', '$tipo', NOW())";
    if ($conn->query($sql) === TRUE) {
        echo "Medidor agregado exitosamente. <a href='abm2.php'>Volver</a>";
    } else {
        echo "Error al agregar el medidor: " . $conn->error;
    }
    $conn->close();
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Medidor</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Agregar Medidor</h1>
        <form method="POST">
            <div class="mb-3">
                <label for="usuario_id" class="form-label">Usuario ID</label>
                <input type="number" class="form-control" id="usuario_id" name="usuario_id" required>
            </div>
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>
            <div class="mb-3">
                <label for="tipo" class="form-label">Tipo</label>
                <input type="text" class="form-control" id="tipo" name="tipo" required>
            </div>
            <button type="submit" class="btn btn-primary">Agregar</button>
            <a href="abm2.php" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</body>
</html>
