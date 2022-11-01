// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract DataLocations {
    uint[] public arr;
    mapping(uint => address) map;
    struct MyStruct {
        uint foo;
    }
    mapping(uint => MyStruct) myStructs;

    function f() public {
        // call _f with state variables
        _f(arr, map, myStructs[1]);

        // get a struct from a mapping
        MyStruct storage myStruct = myStructs[1];
        // create a struct in memory
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(
        uint[] storage _arr,
        mapping(uint => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // do something with storage variables
    }

    // You can return memory variables
    function g(uint[] memory _arr) public returns (uint[] memory) {
        // do something with memory array
    }

    function h(uint[] calldata _arr) external {
        // do something with calldata array
    }
}

/*
 * There are 3 types of data locations - Storage, Memory and CallData
 * Storage - its a state variable of a contract.
 * Memory - its a variable that holds data temp. after exec. it deletes its value
 * CallData - basically acts as pointer to a variable(its used for functional arguments), its value is not copied 
 */

/*
 * If i assign a storage value to a variable name, it acts as a pointer to that value.
 
 * If i assign a memory value to a variable name, it acts as a copy of that value, and operates Independently. 
   Changes to memory will not be saved on blockchain.

 * values that you want to pass as a function argument in a blockchain, should not be saved as a bockchain, to ensure that, we use the memory keyword.
 
 * 
 */