document.addEventListener("DOMContentLoaded", function () {
  document
    .getElementById("login-form")
    .addEventListener("submit", async function (e) {
      e.preventDefault();

      const username = document.getElementById("login-username").value;
      const password = document.getElementById("password").value;

      try {
        const response = await fetch(
          `http://${window.location.hostname}:3000/api/login`,
          {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ username, password }),
          }
        );

        const result = await response.json();

        if (result.success) {
          window.location.href = "home.html";
        } else {
          document.getElementById("error-message").textContent =
            "Credenciales incorrectas.";
        }
      } catch (error) {
        console.error("Error:", error);
        document.getElementById("error-message").textContent =
          "Error al conectar con el servidor.";
      }
    });
});
