const API_URL = "http://localhost/ManejoBaseDeDatos.php";

document.getElementById("btnRegister").addEventListener("click", () => {
    const password = document.getElementById("password").value.trim();
    const email = document.getElementById("email").value.trim();
    const nombre = document.getElementById("nombre").value.trim();
    const direccion = document.getElementById("direccion").value.trim();
    const telefono = document.getElementById("telefono").value.trim();

    if (!nombre || !email || !password || !direccion || !telefono) {
        alert("Por favor, llena todos los campos para registrarte.");
        return;
    }

    const data = {
        action: "register",
        Nombre: nombre,
        Direccion: direccion,
        Telefono: telefono,
        Email: email,
        Password: password
    };

    fetch(API_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data),
    })
        .then((response) => response.json())
        .then((data) => {
            alert(data.message || "Registro exitoso");
        })
        .catch((error) => console.error("Error:", error));
});

document.getElementById("btnLogin").addEventListener("click", () => {
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value.trim();

    if (!email || !password) {
        alert("Por favor, ingresa tu correo electrónico y contraseña.");
        return;
    }

    const data = {
        action: "login",
        Email: email,
        Password: password
    };

    fetch(API_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
    })
        .then((response) => response.json())
        .then((data) => {
            if (data.status === "success") {
                if (data.message === "Bienvenido, Administrador") {
                    // Cambiar la interfaz para el administrador
                    mostrarInterfazAdmin();
                } else {
                    alert("Inicio de sesión exitoso");
                    localStorage.setItem("userData", JSON.stringify(data.user));
                    window.location.href = "pantalla_principal.html";
                }
            } else {
                alert(data.message || "Error al iniciar sesión");
            }
        })
        .catch((error) => console.error("Error:", error));
});

// Función para mostrar la interfaz del administrador
function mostrarInterfazAdmin() {
    document.getElementById("titulo").textContent = "Bienvenido Admin";
    document.getElementById("loginForm").style.display = "none";
    document.getElementById("adminButtons").style.display = "block";
}

// Función para redirigir a la página de ABM
document.getElementById("btnABM1").addEventListener("click", function() {
    window.location.href = "http://localhost/abm1.php"; // Redirige a abm.html
});

document.getElementById("btnABM2").addEventListener("click", function() {
    window.location.href = "http://localhost/abm2.php"; // Redirige a abm.html
});

document.getElementById('btnDashboard').addEventListener('click', function() {
    window.location.href = 'http://localhost/medidor/medidor/dashboard_administrador.php';
});
