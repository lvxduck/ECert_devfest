const Migrations = artifacts.require("Certificates");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
