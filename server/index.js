// importing modules
const express = require("express"); // importando express para hacer el servido mas rapido
const http = require("http"); // importando http para poder usar el protocolo http
const mongoose = require("mongoose");

const app = express(); // inicializando express
const port = process.env.PORT || 3000; // puerto en el que se va a ejecutar el servidor

var server = http.createServer(app); // creando el servidor con http y express

var io = require("socket.io")(server); // inicializando socket.io  (Manera corta de decir var socketio = require('socket.io'); var io = socketio(server);)

// middleware
// client -> middleware -> server
app.use(express.json()); // It is when ther eis data from cliente side going to the server side. But trying to modifiy it before it gets to the server side.

const DB = "mongodb+srv://dereckangeles15071998:Unicornio5.@cluster0.hzt6ytt.mongodb.net/?retryWrites=true&w=majority";
mongoose // Estableciendo la conexion con la base de datos
  .connect(DB)
  .then(() => {
    console.log("connection successful");
  })
  .catch((err) => {
    console.log(err);
  });

server.listen(port, "0.0.0.0", () => {
  console.log(`Server is running on port ${port}`);
});
