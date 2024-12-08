    const API_URL = "http://localhost/ManejoBaseDeDatos.php";

    document.getElementById("btnRegister").addEventListener("click", () => {
        const nombre = document.getElementById("nombre").value.trim();
        const email = document.getElementById("email").value.trim();

        if (!nombre || !email) {
            alert("Por favor, llena todos los campos para registrarte.");
            return;
        }

        const data = {
            action: "register",
            Nombre: nombre,
            Direccion: "Pendiente",
            Telefono: "0000000000",
            Email: email
        };

        fetch(API_URL, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(data)
        })
            .then((response) => response.json())
            .then((data) => {
                alert(data.message || "Registro exitoso");
            })
            .catch((error) => console.error("Error:", error));
    });

    document.getElementById("btnLogin").addEventListener("click", () => {
        const email = document.getElementById("email").value.trim();

        if (!email) {
            alert("Por favor, ingresa tu correo electrónico.");
            return;
        }

        const data = {
            action: "login",
            Email: email
        };

        fetch(API_URL, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(data)
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.status === "success") {
                    alert("Inicio de sesión exitoso. Redirigiendo...");
                    localStorage.setItem("userData", JSON.stringify(data.user));
                    window.location.href = "pantalla_principal.html";
                } else {
                    alert(data.message || "Error al iniciar sesión");
                }
            })
            .catch((error) => console.error("Error:", error));
    });
    // Función para redirigir a la página de ABM
    document.getElementById("btnABM1").addEventListener("click", function() {
        window.location.href = "abm1.html"; // Redirige a abm.html
    });

    document.getElementById("btnABM2").addEventListener("click", function() {
        window.location.href = "abm2.html"; // Redirige a abm.html
    });

    // Función para redirigir al Dashboard
    document.getElementById("btnDashboard").addEventListener("click", function() {
        window.location.href = "dashboard.html"; // Redirige a dashboard.html
    });

