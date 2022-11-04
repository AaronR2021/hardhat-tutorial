// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Payable {
    // Payable address can receive Ether
    address payable public owner;

    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }

    // Function to deposit Ether into this contract.
    // Call this function along with some Ether.
    // The balance of this contract will be automatically updated.
    function deposit() public payable {}

    // Call this function along with some Ether.
    // The function will throw an error since this function is not payable.
    function notPayable() public {}

    // Function to withdraw all Ether from this contract.
    function withdraw() public {
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}
/*
    payable keyword makes the variable possible t hold funds.
    payable variable can get values from payable variables. 
    ! address payable public owner
    ! owner = payable(msg.sender)
    * Constructor will deal with a variable that deals with money 
    ! constructor payable{} 
    * call this function with some ether. 
    ! function deposit() public payable{}
    * balance of address "this" > in this case the contract
    ! address(this).balance 
    * transfer balance to a account
    * owner is address , i.e address to where you want to transfer finds to
    ! (bool success, bytes memory data) = owner.call{value:amount}("");
    ! address payable _to

    ? Think of the keyword payable as a power to give a variable a wallet to store their ethers.

 */


/*

* How to send Ether?
- You can send Ether to other contracts by

- transfer (2300 gas, throws error)
- send (2300 gas, returns bool)
- call (forward all gas or set gas, returns bool)

* How to receive Ether?
- A contract receiving Ether must have at least one of the functions below

- receive() external payable
- fallback() external payable

? receive() is called if msg.data is empty, otherwise fallback() is called.

* Which method should you use?
call in combination with re-entrancy guard is the recommended method to use after December 2019.

Guard against re-entrancy by

making all state changes before calling other contracts
using re-entrancy guard modifier

*/