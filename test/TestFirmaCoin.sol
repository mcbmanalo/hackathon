// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// These files are dynamically created at test time
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/FirmaCoin.sol";

contract TestFirmaCoin {

  function testInitialBalanceUsingDeployedContract() public {
    FirmaCoin firma = FirmaCoin(DeployedAddresses.FirmaCoin());

    uint expected = 10000;

    Assert.equal(firma.getBalance(tx.origin), expected, "Owner should have 10000 FirmaCoin initially");
  }

  function testInitialBalanceWithNewFirmaCoin() public {
    FirmaCoin firma = new FirmaCoin();

    uint expected = 10000;

    Assert.equal(firma.getBalance(tx.origin), expected, "Owner should have 10000 FirmaCoin initially");
  }

}
