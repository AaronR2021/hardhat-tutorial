// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Array {
    // Several ways to initialize an array
    //! syntax => datatype[]

    //? size is determined during runtime
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];

    //* Fixed sized array, all elements initialize to 0
    uint[10] public myFixedSizeArr;

    //* GET element at index i
    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    // Solidity can return the entire array.
    // But this function should be avoided for
    // arrays that can grow indefinitely in length.

    //! memory values are not stored on the blockchain
    //* its destroyed after execution
    //* GET full array
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    //* ADD value to array.
    function push(uint i) public {
        // Append to array
        // This will increase the array length by 1.
        arr.push(i);
    }

    //* DELETE recent value from array
    function pop() public {
        // Remove last element from array
        // This will decrease the array length by 1
        arr.pop();
    }

    //* Length of an array
    function getLength() public view returns (uint) {
        return arr.length;
    }

    //*DELETE specific index
    function remove(uint index) public {
        // Delete does not change the array length.
        // It resets the value at index to it's default value,
        // in this case 0
        delete arr[index];
    }

    function examples() external {
        // create array in memory, only fixed size can be created
        uint[] memory a = new uint[](5);
    }
}

// executing external functions costs less gas as it does not save to memory to use within contract.
// since public functions can be used anywhere, they are saved in memory,
// hence this costs gas, as memory is expensive.

/*
* As for best practices, 
* you should use external if you expect that the function will only ever be called externally,
* and use public if you need to call the function internally.
*/

/*
! public - all can access

! external - Cannot be accessed internally, only externally

! internal - only this contract and contracts deriving from it can access

! private - can be accessed only from this contract
*/

/*
 * The problem with deleting elements in arrays is, it would lead to gaps in between,
 * What we can do is
 * copy the last element
 * save it in the index of the element you want to delete.
 * pop the last element.
 */