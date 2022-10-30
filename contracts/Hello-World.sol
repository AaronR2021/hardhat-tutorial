//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13; //greater that 0.8.13

contract HelloWorld {
    string public greet;
    constructor() {
        greet='Hello World';
    }
}

//! constructor is called the moment the contract is deployed.
