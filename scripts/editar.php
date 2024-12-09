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

// Verificar si se ha enviado un formulario para actualizar el usuario
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    $nombre = $_POST['nombre'];
    $direccion = $_POST['direccion'];
    $telefono = $_POST['telefono'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    $sql = "UPDATE usuario SET Nombre='$nombre', Direccion='$direccion', Telefono='$telefono', Email='$email', Password='$password' WHERE ID=$id";
    if ($conn->query($sql) === TRUE) {
        echo "Usuario actualizado exitosamente. <a href='abm1.php'>Volver</a>";
    } else {
        echo "Error al actualizar: " . $conn->error;
    }
    $conn->close();
    exit;
}

// Obtener los datos del usuario seleccionado para editar
$id = $_GET['id'] ?? null;
if ($id) {
    $sql = "SELECT * FROM usuario WHERE ID=$id";
    $result = $conn->query($sql);
    $usuario = $result->fetch_assoc();
    if (!$usuario) {
        die("Usuario no encontrado.");
    }
} else {
    die("ID de usuario no proporcionado.");
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Usuario</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Editar Usuario</h1>
        <form method="POST">
            <input type="hidden" name="id" value="<?= $usuario['ID'] ?>">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="<?= $usuario['Nombre'] ?>" required>
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">Dirección</label>
                <input type="text" class="form-control" id="direccion" name="direccion" value="<?= $usuario['Direccion'] ?>" required>
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Teléfono</label>
                <input type="text" class="form-control" id="telefono" name="telefono" value="<?= $usuario['Telefono'] ?>" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<?= $usuario['Email'] ?>" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña</label>
                <input type="text" class="form-control" id="password" name="password" value="<?= $usuario['Password'] ?>" required>
            </div>
            <button type="submit" class="btn btn-primary">Actualizar</button>
            <a href="abm1.php" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</body>
</html>
