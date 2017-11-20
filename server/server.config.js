module.exports = {
  apps : [{
    name    : "json-server",
    script  : "../server/server.js",
    watch   : true,
    env: {
      "PORT": 3000,
      "NODE_ENV": "development"
    }
  }]
};
