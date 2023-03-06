// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Array {
    //initialize array
    uint[] public arr;
    uint[] public arr2 = [1,2,3];
    uint8[10] public fixedSize; //holds only 10 blocks in memory

    //Returns only value form array
    function get(uint i) public view returns(uint){
        return arr[i];
    }

    //returns whole array
    function getArr() public view returns (uint[] memory){
        return arr;
    }

    //create an array in memory, but only a fixed size can be created.
    function createArr() public pure{
        uint8[] memory a = new uint8[](10);
    }
    
}
/*
        assert(condition)
if assert condition is true we will move forward in executing the code.
    *  As assert can consume a significant amount of gas and cause transactions to fail, we use it as consistency checks.
    *  To check the validity of a input we use require(condition,"string to display if condition fails");
    *  
*/