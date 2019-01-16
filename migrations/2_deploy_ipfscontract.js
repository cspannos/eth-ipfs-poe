var EthIpfsPoe = artifacts.require("./EthIpfsPoe.sol");
module.exports = function(deployer) {
  deployer.deploy(EthIpfsPoe);
};
