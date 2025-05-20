const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const ldap = require("ldapjs");

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Configuración LDAP con IP privada del AD
const ldapOptions = {
  url: "ldap://10.0.1.145", // ✅ IP privada real del servidor AD
  reconnect: true,
};

app.post("/api/login", async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({
      success: false,
      message: "Datos incompletos",
    });
  }

  const client = ldap.createClient(ldapOptions);

  // Armado del DN correcto (según tu estructura en AD)
  const userDN = `CN=${username},OU=Usuarios,DC=project-redes,DC=local`;

  client.bind(userDN, password, (err) => {
    if (err) {
      console.error("❌ Error de autenticación LDAP:", err.message);
      return res.status(401).json({
        success: false,
        message: "Credenciales inválidas o conexión fallida",
      });
    }

    // Si el bind fue exitoso
    console.log(`✅ Usuario autenticado: ${username}`);
    client.unbind();
    return res.json({
      success: true,
      message: "Autenticación exitosa",
    });
  });
});

app.listen(port, "0.0.0.0", () => {
  console.log(`✅ API LDAP escuchando en http://0.0.0.0:${port}`);
});
