// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Enum {
    // Enum representing shipping status
    // it can hold only one of these possible values
    enum Status {
        Pending, //first value is a default value
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // Default value is the first element listed in
    // definition of the type, in this case "Pending"
    Status public status;
    //Enum name is considered the datatype when declaring variable.

    // Returns uint 
    //! while setting values
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4
    function get() public view returns (Status) {
        return status; //returns default value, i.e Pending
    }

    // Update status by passing uint into input
    function set(Status _status) public {
        status = _status; //assign value by passing corresponding numbers.
    }

    // You can update to a specific enum like this
    function cancel() public {
        status = Status.Canceled;//assign value: method 2
    }

    // delete resets the enum to its first value, 0
    function reset() public {
        delete status;
    }
}