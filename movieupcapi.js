"use strict";
var newrelic = require('newrelic');
var _ = require('lodash');
var dbConfig = {
  host: process.env.DBHOST || '127.0.0.1',
  pass: process.env.DBPASS || 'D1sneyRocks',
  user: process.env.DBUSER || 'movieupc',
  database: process.env.DBDATABASE || 'movieupc'
};
var Hapi = require('hapi');
var server = new Hapi.Server();
server.connection({
    port: process.env.PORT || 3000
});
var Sequelize = require("sequelize");

var sequelize = new Sequelize(dbConfig.database, dbConfig.user, dbConfig.pass, {
  host: dbConfig.host
});
var { graphql, buildSchema } = require('graphql');

/**
 * MovieUPC Model
 */
var MovieUPC = sequelize.define('upc', {
  DVD_Title: Sequelize.STRING,
  Studio: Sequelize.STRING,
  Released: Sequelize.STRING,
  Status: Sequelize.STRING,
  Sound: Sequelize.STRING,
  Versions: Sequelize.STRING,
  Price: Sequelize.STRING,
  Rating: Sequelize.STRING,
  Year: Sequelize.STRING,
  Genre: Sequelize.STRING,
  Aspect: Sequelize.STRING,
  UPC: Sequelize.STRING,
  DVD_ReleaseDate: Sequelize.STRING,
  ID: Sequelize.STRING,
  Timestamp: Sequelize.STRING,
  movieupc_id: {
  	type: Sequelize.INTEGER,
  	autoIncrement: true,
  	primaryKey: true
  }
}, {
	timestamps: false,
	freezeTableName: true
});

server.route({
  method: 'GET',
  path: '/upc/{upc}',
  handler: function (request, reply) {
    var upc = request.params.upc;

    // find upc
    MovieUPC.findOne({ where: {UPC: upc} }).then(function(movie) {
      reply(movie);
    }).catch(function(error){
      reply(error);
    });
  }
});

server.route({
  method: 'POST',
  path: "/upc/{upc}",
  handler: function(request,reply) {
    var movieQLSchema = buildSchema(`
      type Query {
        DVD_Title: String
        Studio: String
        Released: String
        Status: String
        Sound: String
        Versions: String
        Price: String
        Rating: String
        Year: String
        Genre: String
        Aspect: String
        UPC: String
        DVD_ReleaseDate: String
        ID: String
        Timestamp: String
        movieupc_id: Int
      }
    `);

    var upc = request.params.upc;
    var requestedData = (_.size(request.payload) > 0) ? request.payload : `
      {
        DVD_Title
        Studio
        Released
        Status
        Sound
        Versions
        Price
        Rating
        Year
        Genre
        Aspect
        UPC
        DVD_ReleaseDate
        ID
        Timestamp
        movieupc_id
      }
    `;

    // find upc
    MovieUPC.findOne({ where: {UPC: upc} }).then(function(movie) {
      graphql(movieQLSchema, requestedData, movie).then((response) => {
        reply(response.data);
      });
    }).catch(function(error){
      reply(error);
    });
  }
});

server.route({
  method: 'GET',
  path: '/',
  handler: function (request, reply) {
  	var upc = request.query.upc;

  	if (upc) {
  		// find upc
  		MovieUPC.findOne({ where: {UPC: upc} }).then(function(movie) {
  		  reply(movie);
  		}).catch(function(error){
  			reply(error);
  		});
  	} else {
  		reply("Movie UPC API");
  	}
  }
});

server.start(function(){
  console.log('Server running at: ', server.info.uri);
});
