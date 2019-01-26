pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/ProofOfExistence.sol";

contract ProofOfExistence {

  uint public initialBalance = 1 ether;

  function testRegisterFile() {
   

    ProofOfExistence simpleStorage = ProofOfExistence(DeployedAddresses.ProofOfExistence());

    //simpleStorage.set(89);

    //uint expected = 89;

    //Assert.equal(simpleStorage.get(), expected, "It should store the value 89.");
  }

}
