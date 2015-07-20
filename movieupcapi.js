var newrelic = require('newrelic');
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
})

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

    if (upc) {
      // find upc
      MovieUPC.find({ where: {UPC: upc} }).success(function(movie) {
        reply(movie);
      }).error(function(error){
        reply(error);
      });
    } else {
      reply("Movie UPC API");
    }
  }
});

server.route({
  method: 'GET',
  path: '/',
  handler: function (request, reply) {
  	var upc = request.query.upc;

  	if (upc) {
  		// find upc
  		MovieUPC.find({ where: {UPC: upc} }).success(function(movie) {
  		  reply(movie);
  		}).error(function(error){
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
