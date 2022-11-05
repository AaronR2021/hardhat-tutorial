# hardhat-tutorial

This is a basic boiler plate code I've written following the hardhat tutorial on the official documentation. 
https://hardhat.org/tutorial

I've commented a lot of lines of codes to the best of my knowledge, if you feel there needs to be any changes.. please PR

I'll be updating and using this repo for testing and deploying my solidity code .. which I'm currently learning

## Common cmds you'll be using working with this Repo
* npx hardhat test test/testFileName.js
* npx hardhat compile
* npx hardhat run scripts/deploy.js  // for test network
* npx hardhat run scripts/deploy.js --network <network-name>
  
## Learning Solidity
#### In the brance basic-Application, we'll create the following applications
##### EthWallet 
- a basic contract where anyone can send ETH to this contract and only owner of the contract can retrieve eth present in this contract to his address.
- The owner of the contract is the one who uploaded the contact.


## Sidenote
- dont worry about the artifacts and cache folder, they are created on compiling your solidity code.
  


Happy Hacking :)

-ASR
