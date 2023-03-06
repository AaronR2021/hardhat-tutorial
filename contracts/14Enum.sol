// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Enum {
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    //default value is the first value listed.
    //in this case *Status* becomes a datatype with the following values.

    Status public status;

    function Set(Status _status) public returns(Status){
        return status=_status;
    }
    function Get() public view returns(Status){
        return status;
    }
    
    //You can update it to a specific enum like this
    function Reject() public {
        status = Status.Rejected;
    }

    // delete resets the enum to its first value. 
    function reset() public {
        delete status;
    }
}