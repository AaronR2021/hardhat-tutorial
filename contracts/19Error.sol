// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Errors {
    /* There are 3 types of ways to throw an error.
    - require(condition): we use this to validate inputs and conditions before execution. (goes with if/else)
    - revert("Message to user why cond. failed"): is similar to require.
       if the condition fails, it sends a message to user telling it why it failed,
       along with the remaining gas that was assigned to execution.
    -assert(condition) "assert" is a function that can be used to check for conditions that should never be false.
    */

   /*
        The difference between assert and require is as follows:
        - require() checks if the condition is correct to carry on execution. usually input parameters
        if the condition fails, it reverts all changes done in that function and returns the remaining gas.
        - assert() checks for condition that should never occur. if it fails here, the remaining gas will be lost.
        we use it to check for integer overflow or underflow, etc..
    */

   function testErrorRequire(uint _i) public pure {
    require(_i>10,'Input must be greater to 10');
    //if _i is greater to 10, continue else throw the error in the above string format.
   }

    function testErrorRevert(uint _i) public pure {
        // Revert is useful when the condition to check is complex.
        // This code does the exact same thing as the example above
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint8 public num;
    function testAssert() public view {
        //number should always be equal to zero to pass, else fail and loose gas
        assert(num == 0);
    }



}