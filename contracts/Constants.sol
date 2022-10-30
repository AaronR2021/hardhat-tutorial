// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Constants {
    // coding convention to uppercase constant variables
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint public constant MY_UINT = 123;
}

/*
! SideNote:
* we use the keyword constant to specify a variable is a constant
* constants are variables that cannot be changed.
* save a lot of gas
 */