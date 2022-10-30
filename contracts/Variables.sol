// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Variables {
    // State variables are stored on the blockchain.
    string public text = "Hello";
    uint public num = 123;

    function doSomething() public {
        // Local variables are not saved to the blockchain.
        uint i = 456;

        // Global variables provide info about the blockchain
        uint timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // address of the caller
    }
}
/* 
* 3 types of variables
* Local variables - declared inside the function, and not stored on the blockchain.
* State variables - declated outside the function, and not stored on blockchain.
* Global variables- provides info about the blockchain.

*/
