const mongoose = require("mongoose");

const playerSchema = new mongoose.Schema({
  username: {
    type: String,
    trim: true,
  },
  socketDI: {
    type: String,
  },
  score: {
    type: Number,
    default: 0,
  },
  playerType: {
    // if  player is X or 0
    required: true,
    type: String,
  },
});

module.exports = playerSchema;
