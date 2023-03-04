// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract SimpleStorage {
    //State variable to store a number;
    uint public num;
    //the following is a transaction to write to a blockchain
    function set(uint _num) public {
        num=_num;
    }
    //here we just read the values from the blockchain
    function get() public view returns(uint){
        return num;
    }
}