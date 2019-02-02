# How to Avoid Common Attacks

### Integer overflows/underflows

- Using openzeppelin-solidity/contracts/math/SafeMath.sol to increment/decrement Uints 

### Reentrancy attacks

- Function msg.sender.transfer() is not implemented

### Force Sending Ether

- Using payable modify

### Additional security precautions

- Implemented a circuit breaker
- Implemented Contract ownership
- Not Loops inside the contract

