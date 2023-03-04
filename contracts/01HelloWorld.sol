// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract HelloWorld {
    string public greet;
    constructor() {
        greet='Hello World';
    }
    // when you decalre a variable as public, 
    // it basically means anyone can access this variable on the blockchain. 
}