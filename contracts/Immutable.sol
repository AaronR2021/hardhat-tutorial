// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Immutable {
    // coding convention to uppercase constant variables
    address public immutable MY_ADDRESS; //* Declaring a immutable
    uint public immutable MY_UINT;

    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender; //*Assigning values to the immutable
        MY_UINT = _myUint;
    }
}

/*
! Immutables
* Immutables are basically variables that can be set only onces,
* similar to constants, but here they can be set at runtime.
*/