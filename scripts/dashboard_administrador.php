<?php
include 'bd.php'; // Conexión a la base de datos

// Obtener lista de usuarios
$stmt = $pdo->query("SELECT ID AS usuario_id, Nombre FROM usuario");
$usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Obtener el usuario seleccionado y el presupuesto
$usuarioID = isset($_GET['usuario_id']) ? $_GET['usuario_id'] : null;
$presupuesto = isset($_GET['presupuesto']) ? floatval($_GET['presupuesto']) : 100; // Presupuesto predeterminado: 100
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consumo y Presupuesto</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Kodchasan:wght@400;700&family=Gruppo&family=Raleway:wght@400;700&display=swap');
        body {
            font-family: 'Kodchasan', sans-serif;
            text-align: center;
        }
        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        .chart-container {
            background: #f4f4f9;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        select, input {
            padding: 5px;
            font-size: 16px;
            margin: 20px;
        }
    </style>
</head>
<body>
    <h1>Gestión de Consumo y Presupuesto</h1>

    <!-- Formulario para seleccionar usuario y definir presupuesto -->
    <form method="GET">
        <label for="usuario_id">Seleccionar Usuario:</label>
        <select name="usuario_id" id="usuario_id" onchange="this.form.submit()">
            <option value="">-- Seleccione un Usuario --</option>
            <?php foreach ($usuarios as $user): ?>
                <option value="<?= htmlspecialchars($user['usuario_id']) ?>" <?= $usuarioID == $user['usuario_id'] ? 'selected' : '' ?>>
                    <?= htmlspecialchars($user['Nombre']) ?>
                </option>
            <?php endforeach; ?>
        </select>

        <label for="presupuesto">Presupuesto (Bs):</label>
        <input type="number" name="presupuesto" id="presupuesto" value="<?= htmlspecialchars($presupuesto) ?>" onchange="this.form.submit()">
    </form>

    <?php if ($usuarioID): ?>
        <!-- Gráficos -->
        <div class="container">
            <div class="chart-container"><canvas id="consumoPresupuesto"></canvas></div>
            <div class="chart-container"><canvas id="gastoMensual"></canvas></div>
            <div class="chart-container"><canvas id="gastoAcumulado"></canvas></div>
            <div class="chart-container"><canvas id="consumoMensual"></canvas></div>
            <div class="chart-container"><canvas id="distribucionDiaria"></canvas></div>
            <div class="chart-container"><canvas id="consumoPorHora"></canvas></div>
            <div class="chart-container"><canvas id="historialReciente"></canvas></div>
            <div class="chart-container"><canvas id="consumoAnual"></canvas></div>
        </div>

        <script>
            const usuarioID = <?= json_encode($usuarioID) ?>;
            const presupuesto = <?= json_encode($presupuesto) ?>;

            // Paleta de colores personalizada
            const colores = ['#2197a3', '#f71e6c', '#f07868', '#ebb970', '#e7d3b0'];

            async function fetchData() {
                const response = await fetch(`data.php?usuarioID=${usuarioID}&presupuesto=${presupuesto}`);
                return response.json();
            }

            fetchData().then(data => {
                // Crear una gráfica
                function createChart(canvasID, type, labels, datasetLabel, dataValues, backgroundColor, borderColor) {
                    new Chart(document.getElementById(canvasID), {
                        type: type,
                        data: {
                            labels: labels,
                            datasets: [{
                                label: datasetLabel,
                                data: dataValues,
                                backgroundColor: backgroundColor,
                                borderColor: borderColor,
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { display: true, position: 'top' }
                            }
                        }
                    });
                }

                // Gráfica 1: Consumo vs Presupuesto
                createChart('consumoPresupuesto', 'pie', 
                    ['Consumo Real', 'Presupuesto Restante'], 
                    'Consumo vs Presupuesto', 
                    [data.presupuesto.consumo_real, Math.max(0, presupuesto - data.presupuesto.consumo_real)], 
                    [colores[0], colores[1]], 
                    [colores[0], colores[1]]
                );

                // Gráfica 2: Gasto Mensual
                createChart('gastoMensual', 'bar',
                    data.gasto_mensual.map(item => `Mes ${item.mes}`),
                    'Gasto Mensual (Bs)',
                    data.gasto_mensual.map(item => item.gasto_total),
                    colores,
                    colores
                );

                // Gráfica 3: Gasto Acumulado
                createChart('gastoAcumulado', 'line',
                    data.gasto_acumulado.map(item => item.fecha),
                    'Gasto Acumulado (Bs)',
                    data.gasto_acumulado.map(item => item.gasto_acumulado),
                    colores[2],
                    colores[2]
                );

                // Gráfica 4: Consumo Mensual
                createChart('consumoMensual', 'bar',
                    data.consumo_mensual.map(item => `Mes ${item.mes}`),
                    'Consumo Mensual (kWh)',
                    data.consumo_mensual.map(item => item.consumo_mensual),
                    colores,
                    colores
                );

                // Gráfica 5: Distribución Diaria
                createChart('distribucionDiaria', 'line',
                    data.distribucion_diaria.map(item => item.dia),
                    'Distribución Diaria (kWh)',
                    data.distribucion_diaria.map(item => item.consumo_dia),
                    colores[3],
                    colores[3]
                );

                // Gráfica 6: Consumo por Hora
                createChart('consumoPorHora', 'bar',
                    data.consumo_por_hora.map(item => `${item.hora}:00`),
                    'Consumo por Hora (kWh)',
                    data.consumo_por_hora.map(item => item.consumo_hora),
                    colores,
                    colores
                );

                // Gráfica 7: Historial Reciente
                createChart('historialReciente', 'bar',
                    data.consumo_reciente.map(item => item.fecha),
                    'Consumo Reciente (kWh)',
                    data.consumo_reciente.map(item => item.consumo_dia),
                    colores,
                    colores
                );

                // Gráfica 8: Consumo Anual
                createChart('consumoAnual', 'line',
                    data.consumo_anual.map(item => `Año ${item.anio}`),
                    'Consumo Anual (kWh)',
                    data.consumo_anual.map(item => item.consumo_anual),
                    colores[4],
                    colores[4]
                );
            });
        </script>
    <?php else: ?>
        <p>Seleccione un usuario y defina un presupuesto para ver los gráficos.</p>
    <?php endif; ?>
</body>
</html>
