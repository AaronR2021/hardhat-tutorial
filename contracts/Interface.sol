// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.4.19;
  
// A simple interface 
//! Define an interface

interface InterfaceExample{
  
    // Functions having only 
    // declaration not definition
    function getStr(
    ) public view returns(string memory);
    function setValue(
      uint _num1, uint _num2) public;
    function add(
    ) public view returns(uint);
}
  
//! creates the contract that defines the interface
// Contract that implements interface
contract thisContract is InterfaceExample{
  
    // Private variables
    uint private num1;
    uint private num2;
  
    // Function definitions of functions 
    // declared inside an interface
    function getStr(
    ) public view returns(string memory){
        return "GeeksForGeeks";
    }
      
     // Function to set the values 
    // of the private variables
    function setValue(
      uint _num1, uint _num2) public{
        num1 = _num1;
        num2 = _num2;
    }
      
    // Function to add 2 numbers 
    function add(
    ) public view returns(uint){
        return num1 + num2;
    }
      
}
  
//! A new contract
contract call{
      
    //! Creating an object of the interface
    InterfaceExample obj;
  
    function call() public{
        //! initialising the object with the contract it is associated with
        obj = new thisContract();
    }
      
    // Function to print string 
    // value and the sum value
    function getValue(
    ) public returns(uint){
        obj.getStr;
        obj.setValue(10, 16);
        return obj.add();
    }
}

/*
    You can interface with other contracts by declaring an Interface.

    Solidity allows you to call other contracts without having its code, via INterfaces

    > Create an interface with list of functions that can be accible from outside.
    > create a contract that inherits that interface, and defines it.
    > other contract can access this new contract only via the interface. 
    ? Hence you know only functions defined in the interface can be accessed for a contract. 
*/