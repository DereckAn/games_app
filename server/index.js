// importing modules
const express = require("express"); // importando express para hacer el servido mas rapido
const http = require("http"); // importando http para poder usar el protocolo http
const mongoose = require("mongoose");
// const roomModel = require("./models/room");

const app = express(); // inicializando express
const port = process.env.PORT || 3000; // puerto en el que se va a ejecutar el servidor
const Room = require("./models/room");

let server = http.createServer(app); // creando el servidor con http y express

let io = require("socket.io")(server); // inicializando socket.io  (Manera corta de decir var socketio = require('socket.io'); var io = socketio(server);)

// middleware
// client -> middleware -> server
app.use(express.json()); // It is when ther eis data from cliente side going to the server side. But trying to modifiy it before it gets to the server side.

const DB =
  "mongodb+srv://dereckangeles15071998:Unicornio5.@cluster0.hzt6ytt.mongodb.net/?retryWrites=true&w=majority";
io.on("connection", (socket) => {
  console.log("user connected");

  console.log(socket.id);
  socket.on("createGame", async ({ username }) => {
    console.log(username);
    // Now we have to create a game in the database
    try {
      let room = new Room();
      let player = {
        // Aqui estamos creando el player
        socketID: socket.id,
        username,
        playerType: "X",
      };
      room.players.push(player); // Aqui estamos agregando el player al room
      room.turn = player; // Aqui estamos estableciendo el turno
      room = await room.save(); // Aqui estamos guardando el room en la base de datos

      console.log(room);
      const roomID = room._id.toString(); // Aqui estamos obteniendo el id del room
      socket.join(roomID); // Aqui estamos haciendo que el socket se una al room
    
      // Decirle al clietne que el game a sido creado
      // y que se una al room
      // note: Con ioo podemos mandar mensajes a todos los sockets
      // note: Con socket podemos manipular data a mi mismo

      io.to(roomID).emit('createdGameSuccess', room);
    } catch (err) {
      console.log(err);
    }
  });
});

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
