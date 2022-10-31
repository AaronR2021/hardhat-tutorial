// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Mapping {
    // Mapping from address to uint
    mapping(address => uint) public myMap;

    function get(address _addr) public view returns (uint) {
        // Mapping always returns a value.
        // If the value was never set, it will return the default value for that dataType.
        return myMap[_addr];
    }

    function set(address _addr, uint _i) public {
        // Update the value at the address "_addr"
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        // Reset the value to the default value of that datatype
        delete myMap[_addr];
    }
}

contract NestedMapping {
    // Nested mapping (mapping from address to another mapping)
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool) {
        // You can get values from a nested mapping
        // even when it is not initialized, but it will show its default value
        //for that datatype
        return nested[_addr1][_i];
    }

    function set(
        address _addr1,
        uint _i,
        bool _boo
    ) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }
}



/*
* Syntax: mapping(keyType => valueType)
* keyType  : any dataType
* valueType: any dataType including another mapping datatype
*/


/*
! To understand mapping better, watch this video: 
?  https://www.youtube.com/watch?v=Q-wRG7pngn0
 */