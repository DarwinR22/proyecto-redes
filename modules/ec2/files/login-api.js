const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const ldap = require("ldapjs");
const https = require("https");
const fs = require("fs");
const path = require("path");

const app = express();
const port = 443;

// Certificados SSL de Let's Encrypt
const options = {
  key: fs.readFileSync("/etc/letsencrypt/live/redes-project.duckdns.org/privkey.pem"),
  cert: fs.readFileSync("/etc/letsencrypt/live/redes-project.duckdns.org/fullchain.pem")
};

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(express.static("/var/www/html")); // Servir archivos estáticos

// Configuración LDAP
const ldapOptions = {
  url: "ldap://10.0.2.145",
  reconnect: true,
};

// Ruta principal: sirve index.html
app.get("/", (req, res) => {
  res.sendFile(path.join("/var/www/html", "index.html"));
});

// Ruta de login
app.post("/api/login", async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({
      success: false,
      message: "Datos incompletos",
    });
  }

  const client = ldap.createClient(ldapOptions);
  const userPrincipalName = `${username}@project-redes.local`;

  client.bind(userPrincipalName, password, (err) => {
    if (err) {
      console.error("❌ Fallo de autenticación LDAP:", err.message);
      return res.status(401).json({
        success: false,
        message: "Credenciales inválidas o conexión fallida",
      });
    }

    console.log(`✅ Usuario autenticado correctamente: ${userPrincipalName}`);
    client.unbind();

    // ✅ Redirigir a home.html desde backend
    res.json({
      success: true,
      redirect: "/home.html" // el frontend puede usar esto para redirigir
    });
  });
});

// Servidor HTTPS
https.createServer(options, app).listen(port, () => {
  console.log(`✅ API LDAP corriendo en https://0.0.0.0:${port}`);
});
