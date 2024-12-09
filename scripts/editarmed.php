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

// Verificar si se ha enviado un formulario para actualizar el medidor
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    $usuarioId = $_POST['usuario_id'];
    $nombre = $_POST['nombre'];
    $tipo = $_POST['tipo'];

    $sql = "UPDATE medidor SET UsuarioID='$usuarioId', Nombre='$nombre', Tipo='$tipo' WHERE ID=$id";
    if ($conn->query($sql) === TRUE) {
        echo "Medidor actualizado exitosamente. <a href='abm2.php'>Volver</a>";
    } else {
        echo "Error al actualizar: " . $conn->error;
    }
    $conn->close();
    exit;
}

// Obtener los datos del medidor seleccionado para editar
$id = $_GET['id'] ?? null;
if ($id) {
    $sql = "SELECT * FROM medidor WHERE ID=$id";
    $result = $conn->query($sql);
    $medidor = $result->fetch_assoc();
    if (!$medidor) {
        die("Medidor no encontrado.");
    }
} else {
    die("ID de medidor no proporcionado.");
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Medidor</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Editar Medidor</h1>
        <form method="POST">
            <input type="hidden" name="id" value="<?= $medidor['ID'] ?>">
            <div class="mb-3">
                <label for="usuario_id" class="form-label">Usuario ID</label>
                <input type="number" class="form-control" id="usuario_id" name="usuario_id" value="<?= $medidor['UsuarioID'] ?>" required>
            </div>
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="<?= $medidor['Nombre'] ?>" required>
            </div>
            <div class="mb-3">
                <label for="tipo" class="form-label">Tipo</label>
                <input type="text" class="form-control" id="tipo" name="tipo" value="<?= $medidor['Tipo'] ?>" required>
            </div>
            <button type="submit" class="btn btn-primary">Actualizar</button>
            <a href="amb2.php" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</body>
</html>
