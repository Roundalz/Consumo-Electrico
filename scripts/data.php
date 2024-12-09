<?php
header('Content-Type: application/json');

// Conexión a la base de datos
include 'bd.php';

$data = [];

// Validar si se proporcionó un ID de usuario
if (isset($_GET['usuarioID'])) {
    $usuarioID = $_GET['usuarioID'];

    // Recuperar el presupuesto desde los parámetros de la solicitud
    $presupuesto = isset($_GET['presupuesto']) ? floatval($_GET['presupuesto']) : 100; // Presupuesto predeterminado: 100

    // 1. Consumo mensual del usuario
    $query1 = "
        SELECT MONTH(lm.FechaHora) AS mes, SUM(lm.Energia) AS consumo_mensual
        FROM lectura_medidor lm
        JOIN medidor m ON lm.MedidorID = m.ID
        WHERE m.UsuarioID = ?
        GROUP BY MONTH(lm.FechaHora)";
    $stmt1 = $pdo->prepare($query1);
    $stmt1->execute([$usuarioID]);
    $data['consumo_mensual'] = $stmt1->fetchAll(PDO::FETCH_ASSOC);

    // 2. Distribución diaria de consumo
    $query2 = "
        SELECT DAYNAME(lm.FechaHora) AS dia, SUM(lm.Energia) AS consumo_dia
        FROM lectura_medidor lm
        JOIN medidor m ON lm.MedidorID = m.ID
        WHERE m.UsuarioID = ?
        GROUP BY DAYNAME(lm.FechaHora)";
    $stmt2 = $pdo->prepare($query2);
    $stmt2->execute([$usuarioID]);
    $data['distribucion_diaria'] = $stmt2->fetchAll(PDO::FETCH_ASSOC);

    // 3. Gasto acumulado del usuario
    $query3 = "
        SELECT DATE(lm.FechaHora) AS fecha, SUM(lm.Energia * 0.8) AS gasto_acumulado
        FROM lectura_medidor lm
        JOIN medidor m ON lm.MedidorID = m.ID
        WHERE m.UsuarioID = ?
        GROUP BY DATE(lm.FechaHora)";
    $stmt3 = $pdo->prepare($query3);
    $stmt3->execute([$usuarioID]);
    $data['gasto_acumulado'] = $stmt3->fetchAll(PDO::FETCH_ASSOC);

    // 4. Comparación de consumo por hora del día
    $query4 = "
        SELECT HOUR(lm.FechaHora) AS hora, SUM(lm.Energia) AS consumo_hora
        FROM lectura_medidor lm
        JOIN medidor m ON lm.MedidorID = m.ID
        WHERE m.UsuarioID = ?
        GROUP BY HOUR(lm.FechaHora)";
    $stmt4 = $pdo->prepare($query4);
    $stmt4->execute([$usuarioID]);
    $data['consumo_por_hora'] = $stmt4->fetchAll(PDO::FETCH_ASSOC);

    // 5. Consumo vs presupuesto definido
    $query5 = "
        SELECT SUM(lm.Energia) AS consumo_real
        FROM lectura_medidor lm
        JOIN medidor m ON lm.MedidorID = m.ID
        WHERE m.UsuarioID = ?";
    $stmt5 = $pdo->prepare($query5);
    $stmt5->execute([$usuarioID]);
    $consumo_real = $stmt5->fetch(PDO::FETCH_ASSOC)['consumo_real'];
    $data['presupuesto'] = [
        'consumo_real' => $consumo_real,
        'presupuesto' => $presupuesto,
        'diferencia' => $presupuesto - $consumo_real
    ];

    // 6. Historial de consumo reciente (últimos 7 días)
    $query6 = "
        SELECT DATE(lm.FechaHora) AS fecha, SUM(lm.Energia) AS consumo_dia
        FROM lectura_medidor lm
        JOIN medidor m ON lm.MedidorID = m.ID
        WHERE m.UsuarioID = ? AND lm.FechaHora >= CURDATE() - INTERVAL 7 DAY
        GROUP BY DATE(lm.FechaHora)";
    $stmt6 = $pdo->prepare($query6);
    $stmt6->execute([$usuarioID]);
    $data['consumo_reciente'] = $stmt6->fetchAll(PDO::FETCH_ASSOC);

    // 7. Comparativa entre el consumo del usuario y el promedio de otros usuarios
    $query7 = "
        SELECT u.Nombre AS usuario, AVG(lm.Energia) AS promedio_consumo
        FROM usuario u
        JOIN medidor m ON u.ID = m.UsuarioID
        JOIN lectura_medidor lm ON m.ID = lm.MedidorID
        GROUP BY u.ID";
    $stmt7 = $pdo->query($query7);
    $data['comparativa_usuarios'] = $stmt7->fetchAll(PDO::FETCH_ASSOC);

    // 8. Gasto total por mes (NUEVA TABLA)
    $query8 = "
        SELECT MONTH(lm.FechaHora) AS mes, SUM(lm.Energia * 0.8) AS gasto_total
        FROM lectura_medidor lm
        JOIN medidor m ON lm.MedidorID = m.ID
        WHERE m.UsuarioID = ?
        GROUP BY MONTH(lm.FechaHora)";
    $stmt8 = $pdo->prepare($query8);
    $stmt8->execute([$usuarioID]);
    $data['gasto_mensual'] = $stmt8->fetchAll(PDO::FETCH_ASSOC);

    // 9. Resumen de consumo anual (NUEVA TABLA)
    $query9 = "
        SELECT YEAR(lm.FechaHora) AS anio, SUM(lm.Energia) AS consumo_anual
        FROM lectura_medidor lm
        JOIN medidor m ON lm.MedidorID = m.ID
        WHERE m.UsuarioID = ?
        GROUP BY YEAR(lm.FechaHora)";
    $stmt9 = $pdo->prepare($query9);
    $stmt9->execute([$usuarioID]);
    $data['consumo_anual'] = $stmt9->fetchAll(PDO::FETCH_ASSOC);

} else {
    $data['error'] = 'No se proporcionó un ID de usuario válido.';
}

// Retornar los datos como JSON
echo json_encode($data);
?>
