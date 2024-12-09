<?php

// Configuración para la conexión a la base de datos
$host = "localhost";
$dbname = "bd_consumo_electrico";
$username = "root";
$password = ""; // Cambia esto si tienes un password configurado

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Error al conectar con la base de datos: " . $e->getMessage());
}
?>


