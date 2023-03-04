// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Variables {

/*
There are 3 types of variables
- local
    * stored only within the fucntion and not the blockchain
- state
    * declared outside a function
    * stored on the blockchain
- global
    * provides information about the blockchain
*/

//state variables
string public text = "Hello World";
function doSomething() public {
    //this is not saved on blockchain. i.e local variables
    //but executing this function will still cost gas
    uint i = 2;

    //!Global Variables
    uint timestamp = block.timestamp; // Current block timestamp
    address sender = msg.sender; // address of the caller of this function
    
}
}