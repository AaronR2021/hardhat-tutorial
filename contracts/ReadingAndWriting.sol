// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SimpleStorage {
    // State variable to store a number
    uint public num;

    // You need to send a transaction to write to a state variable.
    function set(uint _num) public {
        num = _num;
    }

    // You can read from a state variable without sending a transaction.
    function get() public view returns (uint) {
        return num;
    }
}

/*
define "view" is used when you just want to read a value from the blockchain.
no gas is used when your reading from a blockchain.

gas is used in a transaction only when you right to a blockchain!
 */