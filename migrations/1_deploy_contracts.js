const ConvertLib = artifacts.require("ConvertLib");
const FirmaCoin = artifacts.require("FirmaCoin");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, FirmaCoin);
  deployer.deploy(FirmaCoin);
};
