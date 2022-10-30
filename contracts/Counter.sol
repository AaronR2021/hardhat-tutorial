// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13; //greater that 0.8.13

contract Counter {
    uint count; //declared a variable called count

    // Function to gets the current count
    function get() public view returns (uint) {
        return count;
    }

    // Function to increment count by 1
    function inc() public {
        count += 1;
    }

    // Function to decrement count by 1
    function dec() public {
        // This function will fail if count = 0
        count -= 1;
    }
}