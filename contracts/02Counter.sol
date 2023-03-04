// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract CounterApp {
    uint public count;

    constructor() {
        count=0;
    }
    function get() public view returns(uint){
        return count;
    }
    function inc() public returns (uint) {
        return count+=1;
    }
    function dec() public returns (uint) {
        return count-=1;
    }
}
// uint holds positive integers. based on the max value you can set the datatype appropreatly( uint8,..., uint256)
// a view states that this function can only read values from the contract, but not change any values. hence it does not cost gas
