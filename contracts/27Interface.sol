
//In an interface, you cannot define a function.
//Can inherit from other intrefaces.
//The declared function that has an interface must be *External*
//There is no constructor in the interface
//Cannot declare state variable in the interface

// SPDX-License-Identifier: MIT
contract Counter {
    uint public count;
    function increment() external { //function connected to interface should be declared external
        count+=1;
    }
}

interface ICounter {
    function count() external view returns(uint);//function connected to anything outside the interface should be declared external
    function increment() external;
}

contract MyContract {
    function incrementCounter(address _counter) external { //always pass the address of who is accessing the function in the contract
        ICounter(_counter).increment();
    }
    function getCount(address _counter) external view returns (uint) {
        return ICounter(_counter).count();
    }

}