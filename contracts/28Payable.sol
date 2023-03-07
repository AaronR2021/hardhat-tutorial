// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Payable {

    address payable public owner;//payable declared address can recieve ethers

    constructor() payable { // you can make a constructor payable. it means you can send ethers during the initial phase itself of a contract
    // ex. paying to use the contract.

    owner = payable(msg.sender); //convert an address to payable

    }

    //send ether to this contract
    function deposit() public payable{ //call this function alonf with some ether and balance of this 
    //contract will automatically be updated

    }

    function withdraw() public {
        uint amount = address(this).balance;//this ref. to "this contract object"
        (bool success,)=owner.call{value:amount}("");
        require(success, "Failed to send Ether");
    }


}



// Functions and addresses declared payable can receive ether into the contract.