// Variables globales
const userData = JSON.parse(localStorage.getItem("userData")); // Obtener los datos del usuario desde Local Storage
const apiUrl = "http://localhost/ManejoBaseDeDatos.php"; // URL del backend
let medidorSeleccionadoID = null;
let intervalo; // Variable para almacenar el intervalo de medición
let medicionActiva = false; // Variable para controlar si la medición está activa

// Verificar si el usuario está autenticado
if (!userData || !userData.ID) {
    alert("No estás autenticado. Redirigiendo al inicio de sesión.");
    window.location.href = "index.html"; // Redirige al inicio de sesión si no está autenticado
}

// Extraer el ID del usuario
const userID = userData.ID;
// Modificado por Kenneth: Generar dinámicamente el enlace del dashboard
document.addEventListener("DOMContentLoaded", () => {
    const dashboardLink = document.getElementById('dashboardLink');
    if (dashboardLink) {
        const presupuesto = 60; // Puedes cambiar el valor del presupuesto si es necesario
        dashboardLink.href = `http://localhost/medidor/medidor/dashboard_usuario.php?usuario_id=${userID}&presupuesto=${presupuesto}`;
    }
});

// Cargar datos del usuario
function cargarDatosUsuario() {
    fetch(`${apiUrl}?action=get_usuario&id=${userID}`)
        .then((response) => response.json())
        .then((data) => {
            document.getElementById("nombreUsuario").textContent = data.Nombre;
            document.getElementById("emailUsuario").textContent = data.Email;
            document.getElementById("direccionUsuario").textContent = data.Direccion || "No proporcionada";
            document.getElementById("telefonoUsuario").textContent = data.Telefono || "No proporcionado";
        })
        .catch((error) => console.error("Error al cargar los datos del usuario:", error));
}

// Cargar medidores del usuario
function cargarMedidores() {
    fetch(`${apiUrl}?action=get_medidores&usuarioID=${userID}`)
        .then((response) => response.json())
        .then((data) => {
            const tabla = document.getElementById("tablaMedidores");
            tabla.innerHTML = ""; // Limpiar tabla

            data.forEach((medidor) => {
                const fila = document.createElement("tr");
                fila.innerHTML = `
                    <td>${medidor.ID}</td>
                    <td>${medidor.Nombre}</td>
                    <td>${medidor.Tipo}</td>
                    <td>${medidor.FechaRegistro}</td>
                    <td><button class="btnSeleccionar" onclick="seleccionarMedidor(${medidor.ID})">Seleccionar Medidor</button></td>
                `;
                tabla.appendChild(fila);
            });
        })
        .catch((error) => console.error("Error al cargar los medidores:", error));
}

// Función para seleccionar el medidor
function seleccionarMedidor(medidorID) {
    const boton = document.querySelector(`button[onclick="seleccionarMedidor(${medidorID})"]`);

    if (medidorSeleccionadoID === medidorID) {
        // Si ya está seleccionado, se detiene y oculta la sección
        medidorSeleccionadoID = null;
        boton.textContent = "Seleccionar Medidor";
        document.getElementById("medidorSeleccionado").style.display = "none";
        
        document.getElementById("medicionesMedidor").style.display = "none";
        return;
    }

    // Si no está seleccionado, se actualiza el botón y carga datos
    medidorSeleccionadoID = medidorID;
    boton.textContent = "Dejar de seleccionar";

    fetch(`${apiUrl}?action=get_medidor&id=${medidorID}`)
        .then((response) => response.json())
        .then((medidor) => {
            document.getElementById("medidorSeleccionado").style.display = "block";
            document.getElementById("medicionesMedidor").style.display = "block";
            document.getElementById("datosMedicion").style.display = "block";
            document.getElementById("medidorID").textContent = medidor.ID || "N/A";
            document.getElementById("medidorNombre").textContent = medidor.Nombre || "N/A";
            document.getElementById("medidorTipo").textContent = medidor.Tipo || "N/A";
            document.getElementById("medidorFechaRegistro").textContent = medidor.FechaRegistro || "N/A";

            cargarYMostrarMediciones(medidorID);
        })
        .catch((error) => console.error("Error al obtener datos del medidor:", error));
}

//* Función para mostrar los datos de medición
function mostrarDatosMedicion(medidorID) {
    const tabla = document.getElementById("tablaMediciones");

    setInterval(() => {
        fetch(`${apiUrl}?action=obtener_datos_medicion&medidorID=${medidorID}`)
            .then((response) => response.json())
            .then((data) => {
                if (data.status === "success") {
                    const medicion = data.datos;
                    const nuevaFila = document.createElement("tr");

                    nuevaFila.innerHTML = `
                        <td>${new Date().toLocaleString()}</td>
                        <td>${medicion.Corriente_rms.toFixed(2)} A</td>
                        <td>${medicion.Voltaje_rms.toFixed(2)} V</td>
                        <td>${medicion.Potencia_activa.toFixed(2)} W</td>
                        <td>${medicion.Energia.toFixed(2)} kWh</td>
                    `;
                    tabla.prepend(nuevaFila);
                } else {
                    console.warn("No hay datos nuevos:", data.message);
                }
            })
            .catch((error) => console.error("Error al obtener datos de medición en tiempo real:", error));
    }, 10000); // Actualizar cada 10 segundos
}

// Función para cargar y mostrar mediciones guardadas
function cargarYMostrarMediciones(medidorID) {
    console.log("Cargando mediciones para el medidor ID:", medidorID); // Verifica que la función se llama

    const tabla = document.getElementById("tablaMediciones");
    tabla.innerHTML = ""; // Limpiar tabla

    fetch(`${apiUrl}?action=get_mediciones&medidorID=${medidorID}`)
        .then((response) => response.json())
        .then((mediciones) => {
            console.log("Mediciones recibidas:", mediciones); // Verifica los datos recibidos

            if (mediciones.length > 0) {
                mediciones.forEach((medicion) => {
                    const fila = document.createElement("tr");
                    fila.innerHTML = `
                        <td>${medicion.FechaHora}</td>
                        <td>${medicion.Corriente_rms} A</td>
                        <td>${medicion.Voltaje_rms} V</td>
                        <td>${medicion.Potencia_activa} W</td>
                        <td>${medicion.Potencia_aparente} W</td>
                        <td>${medicion.Energia} kWh</td>
                    `;
                    tabla.appendChild(fila);
                });
            } else {
                cargarDatosPredeterminados();
            }

            document.getElementById("medicionesMedidor").style.display = "block";
        })
        .catch((error) => {
            console.error("Error al cargar mediciones:", error);
        });
}

// Función para obtener y mostrar mediciones
function obtenerMedicion() {
    console.log("Enviando solicitud de medición...");
    fetch("http://192.168.117.172/comenzar_medicion", {
        method: 'GET',
        mode: 'cors',  // Agregar la opción CORS
    })
    .then(response => response.json())
    .then(data => {
        console.log("Datos de medición:", data);

        // Enviar los datos de medición a la base de datos
        enviarDatosAMedidor(data);
    })
    .catch(error => {
        console.error("Error al obtener datos de medición:", error);
    });
}

// Función para enviar los datos de medición al servidor (PHP)
function enviarDatosAMedidor(data) {
    const postData = {
        action: 'add_lectura',
        MedidorID: medidorSeleccionadoID,
        Corriente_rms: data.corriente_rms,
        Voltaje_rms: data.voltaje_rms,
        Potencia_activa: data.potencia_activa,
        Potencia_aparente: data.potencia_aparente,
        Energia: data.energia
    };

    fetch("http://localhost/ManejoBaseDeDatos.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(postData)
    })
    .then(response => response.json())
    .then(data => {
        console.log("Respuesta de la base de datos:", data);
        cargarYMostrarMediciones(medidorSeleccionadoID);
    })
    .catch(error => {
        console.error("Error al enviar datos a la base de datos:", error);
    });


}

// Función para iniciar las mediciones cada 10 segundos
document.getElementById("btnIniciarMedicion").addEventListener("click", function() {
    console.log("Comenzando mediciones...");
    alert("Medicion iniciada");
    intervalo = setInterval(obtenerMedicion, 10000); // Llama a obtenerMedicion cada 10 segundos
    document.getElementById("btnIniciarMedicion").style.display = "none";

});

// Función para detener las mediciones
document.getElementById("btnDetenerMedicion").addEventListener("click", function() {
    console.log("Deteniendo mediciones...");
    alert("Medicion detenida");
    clearInterval(intervalo); // Detiene el intervalo
    document.getElementById("btnIniciarMedicion").style.display = "";
});

// Abrir modal para agregar medidor
document.getElementById("btnAgregarMedidor").addEventListener("click", () => {
    document.getElementById("modalAgregarMedidor").style.display = "flex";
});

// Cerrar modal
document.getElementById("btnCerrarModal").addEventListener("click", () => {
    document.getElementById("modalAgregarMedidor").style.display = "none";
});

// Registrar nuevo medidor
document.getElementById("formAgregarMedidor").addEventListener("submit", (event) => {
    event.preventDefault();

    const nombre = document.getElementById("nombreMedidor").value;
    const tipo = document.getElementById("tipoMedidor").value;

    fetch(apiUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            action: "add_medidor",
            UsuarioID: userID,
            Nombre: nombre,
            Tipo: tipo,
        }),
    })
        .then((response) => response.json())
        .then((data) => {
            alert("Medidor registrado con éxito");
            document.getElementById("modalAgregarMedidor").style.display = "none";
            cargarMedidores();
        })
        .catch((error) => console.error("Error al agregar el medidor:", error));
});
document.addEventListener("DOMContentLoaded", function () {
    const verTodasMedicionesBtn = document.getElementById("verTodasMedicionesBtn");
    const ventanaFlotante = document.getElementById("ventanaFlotante");
    const cerrarVentana = document.getElementById("cerrarVentana");
    const tablaMedicionesFlotante = document.getElementById("tablaMedicionesFlotante").querySelector("tbody");

    // Cambié la referencia de medidorSeleccionado a medidorSeleccionadoID
    verTodasMedicionesBtn.addEventListener("click", function () {
        if (medidorSeleccionadoID) {
            fetch(`${apiUrl}?action=get_mediciones_completas&medidorID=${medidorSeleccionadoID}`)
                .then((response) => response.json())
                .then((data) => {
                    console.log(data); 
                    if (data.length) {
                        tablaMedicionesFlotante.innerHTML = data
                            .map(
                                (medicion) => `
                                    <tr>
                                        <td>${medicion.ID}</td>
                                        <td>${medicion.MedidorID}</td>
                                        <td>${medicion.FechaHora}</td>
                                        <td>${medicion.Corriente_rms}</td>
                                        <td>${medicion.Voltaje_rms}</td>
                                        <td>${medicion.Potencia_activa}</td>
                                        <td>${medicion.Potencia_aparente}</td>
                                        <td>${medicion.Energia}</td>
                                    </tr>
                                `
                            )
                            .join("");
                    } else {
                        tablaMedicionesFlotante.innerHTML = "<tr><td colspan='8'>No hay mediciones disponibles.</td></tr>";
                    }
                    ventanaFlotante.style.display = "block";
                })
                .catch((error) => console.error("Error al cargar las mediciones:", error));
        }
    });

    // Event listener para cerrar la ventana flotante
    cerrarVentana.addEventListener("click", function () {
        ventanaFlotante.style.display = "none";
    });
});


// Inicializar la pantalla
cargarDatosUsuario();
cargarMedidores();
