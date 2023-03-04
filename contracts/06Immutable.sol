// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Immutable {
//immutables are variables, where you can assign its value only once
address public immutable MY_ADDRESS;
uint8 public immutable value;
constructor(uint8 Inputvalue){
    value=Inputvalue;
    MY_ADDRESS=msg.sender;
}

}