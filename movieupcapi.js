'use strict'

const mongoose = require('mongoose')
const Hapi = require('hapi')

const server = Hapi.server({
  port: process.env.PORT || 3000
})
const mongoHost = process.env.mongo_host || 'localhost'
const mongoPort = process.env.mongo_port || '27017'
const mongoCollection = process.env.mongo_collection || 'movieupc'
const mongoDbUrl = `mongodb://${mongoHost}:${mongoPort}/${mongoCollection}`

mongoose.connect(mongoDbUrl)

const schema = new mongoose.Schema({
  DVD_Title: String,
  Studio: String,
  Released: String,
  Status: String,
  Sound: String,
  Versions: String,
  Price: String,
  Rating: String,
  Year: String,
  Genre: String,
  Aspect: String,
  UPC: String,
  DVD_ReleaseDate: String,
  ID: String,
  Timestamp: String
})

// disable until data can be sanitized
// schema.index({ 'UPC': 1 }, { unique: true })

const Movie = mongoose.model('Movie', schema)

// example UPC  024543155782
server.route({
  method: 'GET',
  path: '/upc/{upc}',
  handler: async (request, h) => {
    const { upc } = request.params

    try {
      const movie = await Movie.findOne({ UPC: upc })

      return movie
    } catch (error) {
      return error
    }
  }
})

server.route({
  method: 'GET',
  path: '/',
  handler: (request, h) => {
    return 'Movie UPC API'
  }
})

const init = async () => {

  await server.start();
  console.log(`Server running at: ${server.info.uri}`);
};

process.on('unhandledRejection', (err) => {

  console.log(err);
  process.exit(1);
});

init();
