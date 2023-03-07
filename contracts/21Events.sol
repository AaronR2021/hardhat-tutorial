// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Events {
    /*
        Why use Events?
        - Cheap form of storage
        - The external applications can update based on what events are thrown
        =>They are basically logs in the smart contract.
        - Events are defined using the event keyword and emited using the emit keyword.
        - when defineing the event you can index a parameter, it means you can search based on the indexed keyword.
        - you emit a event when a certain condition is met.
     */

    event Log(address indexed sender,string message);
    event AnotherLog(uint16 indexed id,string message);
    
    function test() public {
        emit Log(msg.sender,"Hello World"); //this is what the application recieves when the test() function is called. 
        emit AnotherLog(21, "Hello EVM");   //this is what the application recieves when the test() function is called.
    }

}