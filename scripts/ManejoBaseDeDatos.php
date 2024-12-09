<?php
header("Access-Control-Allow-Origin: *"); // Permitir solicitudes desde cualquier origen
header("Access-Control-Allow-Methods: POST, GET, OPTIONS"); // Métodos permitidos
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Encabezados permitidos
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "bd_consumo_electrico";

$admins = [
    ["email" => "ronald.narvaez@gmail.com", "password" => "admin123"],
    ["email" => "alejandro.mollinedo@ucb.edu.bo", "password" => "admin456"]
];

try {
    // Conectar a la base de datos usando PDO
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Manejar solicitudes GET
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        if (isset($_GET['action'])) {
            if ($_GET['action'] === 'get_usuario') {
                // Obtener datos de un usuario por ID
                $id = intval($_GET['id']);
                $stmt = $conn->prepare("SELECT * FROM usuario WHERE ID = :ID");
                $stmt->bindParam(':ID', $id);
                $stmt->execute();
                $user = $stmt->fetch(PDO::FETCH_ASSOC);
                echo json_encode($user);
            }elseif ($_GET['action'] === 'get_mediciones') {
                $medidorID = intval($_GET['medidorID']);
                $stmt = $conn->prepare("SELECT * FROM lectura_medidor WHERE MedidorID = :MedidorID ORDER BY FechaHora DESC LIMIT 10");
                $stmt->bindParam(':MedidorID', $medidorID);
                $stmt->execute();
                $mediciones = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode($mediciones);
            }elseif ($_GET['action'] === 'get_mediciones_completas') {
                $medidorID = intval($_GET['medidorID']);
                $stmt = $conn->prepare("SELECT * FROM lectura_medidor WHERE MedidorID = :MedidorID ORDER BY FechaHora DESC");
                $stmt->bindParam(':MedidorID', $medidorID);
                $stmt->execute();
                $mediciones = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode($mediciones);
            }elseif ($_GET['action'] === 'obtener_datos_medicion') {
                $medidorID = $_GET['medidorID'];
                $query = "SELECT * FROM lectura_medidor WHERE MedidorID = $medidorID ORDER BY FechaHora DESC LIMIT 1";
                $result = $conn->query($query);
            
                if ($result->num_rows > 0) {
                    echo json_encode(["status" => "success", "datos" => $result->fetch_assoc()]);
                } else {
                    echo json_encode(["status" => "error", "message" => "No hay datos disponibles"]);
                }
            }
            elseif ($_GET['action'] === 'get_medidor') {
                $medidorID = intval($_GET['id']); // Asegúrate de que el parámetro 'id' esté presente
                $stmt = $conn->prepare("SELECT * FROM medidor WHERE ID = :ID");
                $stmt->bindParam(':ID', $medidorID);
                $stmt->execute();
                $medidor = $stmt->fetch(PDO::FETCH_ASSOC);
                if ($medidor) {
                    echo json_encode($medidor);
                } else {
                    echo json_encode(["status" => "error", "message" => "Medidor no encontrado"]);
                }
            }elseif ($_GET['action'] === 'get_medidores') {
                // Obtener medidores asociados a un usuario
                $usuarioID = intval($_GET['usuarioID']);
                $stmt = $conn->prepare("SELECT * FROM medidor WHERE UsuarioID = :UsuarioID");
                $stmt->bindParam(':UsuarioID', $usuarioID);
                $stmt->execute();
                $medidores = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode($medidores);
            } else {
                echo json_encode(["status" => "error", "message" => "Acción no válida"]);
            }
        } else {
            echo json_encode(["status" => "error", "message" => "Acción no especificada"]);
        }
    }
    // Manejar solicitudes POST
    elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $data = json_decode(file_get_contents("php://input"), true);

        if (!isset($data['action'])) {
            echo json_encode(["status" => "error", "message" => "Acción no especificada"]);
            exit;
        }

        switch ($data['action']) {
            case "register":
                // Registrar un nuevo usuario
                error_log("Datos recibidos para registro: " . print_r($data, true)); // Registro en logs
                $stmt = $conn->prepare("INSERT INTO usuario (Nombre, Direccion, Telefono, Email, Password) 
                            VALUES (:Nombre, :Direccion, :Telefono, :Email, :Password)");
                $stmt->bindParam(':Nombre', $data['Nombre']);
                $stmt->bindParam(':Direccion', $data['Direccion']);
                $stmt->bindParam(':Telefono', $data['Telefono']);
                $stmt->bindParam(':Email', $data['Email']);
                $stmt->bindParam(':Password', $data['Password']); // Asegúrate de que el nombre del campo sea "contraseña"
                try {
                    $stmt->execute();
                    echo json_encode(["status" => "success", "message" => "Usuario registrado"]);
                } catch (PDOException $e) {
                    error_log("Error al registrar usuario: " . $e->getMessage());
                    echo json_encode(["status" => "error", "message" => "Error al registrar: " . $e->getMessage()]);
                }
                
                break;

            case "login":
                // Validar si es administrador
                foreach ($admins as $admin) {
                    if (strtolower($admin['email']) === strtolower($data['Email']) && $admin['password'] === $data['Password']) {
                        echo json_encode(["status" => "success", "message" => "Bienvenido, Administrador"]);
                        exit; // Salir después de autenticar al administrador
                    }
                }



                // Verificar si el usuario existe
                $stmt = $conn->prepare("SELECT * FROM usuario WHERE Email = :Email AND Password = :Password");
                $stmt->bindParam(':Email', $data['Email']);
                $stmt->bindParam(':Password', $data['Password']); // Usar el mismo nombre de columna
                $stmt->execute();
                $user = $stmt->fetch(PDO::FETCH_ASSOC);

                if ($user) {
                    echo json_encode(["status" => "success", "user" => $user]);
                } else {
                    echo json_encode(["status" => "error", "message" => "Correo o contraseña incorrectos"]);
                }
                break;


            case "add_medidor":
                // Agregar un nuevo medidor
                $stmt = $conn->prepare("INSERT INTO medidor (UsuarioID, Nombre, Tipo) VALUES (:UsuarioID, :Nombre, :Tipo)");
                $stmt->bindParam(':UsuarioID', $data['UsuarioID']);
                $stmt->bindParam(':Nombre', $data['Nombre']);
                $stmt->bindParam(':Tipo', $data['Tipo']);
                if ($stmt->execute()) {
                    echo json_encode(["status" => "success", "message" => "Medidor agregado"]);
                } else {
                    echo json_encode(["status" => "error", "message" => "Error al agregar medidor"]);
                }
                break;

            case "add_lectura":
                // Registrar una nueva lectura
                $stmt = $conn->prepare(
                    "INSERT INTO lectura_medidor (MedidorID, FechaHora, Corriente_rms, Voltaje_rms, Potencia_activa, Potencia_aparente, Energia) 
                     VALUES (:MedidorID, NOW(), :Corriente_rms, :Voltaje_rms, :Potencia_activa, :Potencia_aparente, :Energia)"
                );
                $stmt->bindParam(':MedidorID', $data['MedidorID']);
                $stmt->bindParam(':Corriente_rms', $data['Corriente_rms']);
                $stmt->bindParam(':Voltaje_rms', $data['Voltaje_rms']);
                $stmt->bindParam(':Potencia_activa', $data['Potencia_activa']);
                $stmt->bindParam(':Potencia_aparente', $data['Potencia_aparente']);
                $stmt->bindParam(':Energia', $data['Energia']);
                if ($stmt->execute()) {
                    echo json_encode(["status" => "success", "message" => "Lectura registrada"]);
                } else {
                    echo json_encode(["status" => "error", "message" => "Error al registrar lectura"]);
                }
                break;
            
            default:
                echo json_encode(["status" => "error", "message" => "Acción no válida"]);
                break;
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Método no permitido"]);
    }
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "Error en la conexión: " . $e->getMessage()]);
}

// Cerrar conexión
$conn = null;
?>
