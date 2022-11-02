// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Event {
    // Event declaration
    // Up to 3 parameters can be indexed.
    // Indexed parameters helps you filter the logs by the indexed parameter
    event Log(address indexed sender, string message);
    //sender parameter can be searched/queried from the front end
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}


//!Side Note
/*
 The Ethereum Virtual Machine have this logs functionality. 
 When things happen in a blockchain -> EVM -> writes to log(you can get this log to read block info)
 Logs and events synonymous. 

 EVM writes these logs to a specific type of datastructure.
 These logs cannot be accessed by the smart contract, hence its a cheap form of storage. 

 So we can still print information that is important to us. without saving anything to the blocks

 eg. Transaction happens => event is emited => saved in log data structure =>
 front end listens to these events, based on the filters they set.

 In total there are 4 parameters in a given log.
 The first parameter is set by the EVM, its basically the signature of the given event.
 
 While looking at the above code you might have noticed the keyword "indexed" in the event defination.
 indexed keyword is nothing but searchable parameters saved in the log. 
 So basically it means its easy to search parameters saved as indexed, in the log data structur. 

 ! syntax
 event eventName(dataType parameter,...) //? Declaring the event
 emit eventName(values,...) //? writing the events to logs, from where the front end can access it.
 */