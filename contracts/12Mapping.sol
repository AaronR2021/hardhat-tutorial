// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
contract Mapping {
    mapping(address=>uint8) balance;
    constructor(){
        balance[msg.sender]=10;
    }
    function get(address _address) public view returns(uint8){
        return balance[_address];
    }
    function set(address _addr, uint8 tokens) public{
        balance[_addr]=tokens;
    }
    function remove(address _address) public{
        delete balance[_address];
    }
}

contract NestedMapping {
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool) {
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }
}