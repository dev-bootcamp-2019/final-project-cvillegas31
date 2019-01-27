# proof-of-ex

ConsenSysAcademy Final Project

Proof of Existence 

This dapp Will help to prove that a certain document/file was created on a particular date and time by a particular user.

1. Technologies

FrontEnd: React JS.

Backend: Ethereum Blockchain.

2. Prerequisites

Operating system: any version of Ubuntu 16.04.
Software: npm v6.4.1 and node v11.2.0
Metamask

3. Install Truffle and Ganache-CLI

Run the following command:

$ sudo npm install -g ganache-cli truffle

Run Ganache CLI:

$ ganache-cli

Ganache CLI automatically creates 10 accounts associated with 10 private keys. Each account has 100 ethers for testing purpose.

You need to copy private key in ganache-cli, then open metamask -> click on account -> click on "Import Account" -> put private key into field -> click Import -> switch account (if needed). Imported account should have 100Eth. Do not forget to select network "Localhost 8545"


4. Change to the project directory

Importante: keep the name proof-of-ex as the root of the project.

cd proof-of-ex/


5. Run the following commands:

$ npm install

$ truffle compile 

$ truffle migrate 

$ npm run start


6. Launch the application from a browser:

http://localhost:3000/














