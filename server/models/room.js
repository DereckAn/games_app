const mongoose = require("mongoose");
const playerSchema = require("./player");


// Aqui estamos haciendo el modelo de la base de datos
const roomSchema = new mongoose.Schema({
    occupancy: { // how many players will be in the room
        type: Number,
        default: 2
    },
    maxRounds: {
        type: Number,
        default: 6
    },
    currentRound: {
        required: true,
        type: Number,
        default: 1
    },
    players: [playerSchema],
    isJoin: {
        type: Boolean,
        default: true
    },
    turn: playerSchema,
    turnIndex: {
        type: Number,
        default: 0
    },
});

const roomModel = mongoose.model("room", roomSchema); // Aqui estamos transformando el schema en un modelo
module.exports = roomModel; // Aqui estamos exportando el modelo para poder usarlo en otros archivos