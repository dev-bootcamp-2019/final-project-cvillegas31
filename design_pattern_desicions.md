
Emergency Stop Pattern: Add an option to disable critical contract functionality in case of an emergency.

Applicability

Use the Emergency Stop pattern when the Prof-of-ex dapp is not able to use the storage mechanism. In this case, you have the ability to pause the contract.

Implementation:

In order to stop (in case of an emergency) or resume the contract you will use the state variable: isStopped (Boolean), which is initialized as false during contract creation. 


1. Stop the contract. The state variable has to be set to true by calling the stopContract function.

2. Resume the contract. The state variable has to be set to false by calling the resumeContract function.






