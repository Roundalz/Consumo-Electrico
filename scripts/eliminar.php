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

$id = $_GET['id'] ?? null;

if ($id) {
    $sql = "DELETE FROM usuario WHERE ID=$id";
    if ($conn->query($sql) === TRUE) {
        echo "Usuario eliminado exitosamente. <a href='abm1.php'>Volver</a>";
    } else {
        echo "Error al eliminar: " . $conn->error;
    }
} else {
    echo "ID de usuario no proporcionado. <a href='abm1.php'>Volver</a>";
}

$conn->close();
?>
