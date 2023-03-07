// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Base {
    // Private function can only be called
    // - inside this contract
    // Contracts that inherit this contract cannot call this function.
    function privateFunc() private pure returns (string memory) {
        return "private function called";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();
    }

    // Internal function can be called
    // - inside this contract
    // - inside contracts that inherit this contract
    function internalFunc() internal pure returns (string memory) {
        return "internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    // Public functions can be called
    // - inside this contract
    // - inside contracts that inherit this contract
    // - by other contracts and accounts
    function publicFunc() public pure returns (string memory) {
        return "public function called";
    }

    // External functions can only be called
    // - by other contracts and accounts
    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

    // This function will not compile since we're trying to call
    // an external function here.
    // function testExternalFunc() public pure returns (string memory) {
    //     return externalFunc();
    // }

    // State variables
    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";
    // State variables cannot be external so this code won't compile.
    // string external externalVar = "my external variable";
}

contract Child is Base {
    // Inherited contracts do not have access to private functions
    // and state variables.
    // function testPrivateFunc() public pure returns (string memory) {
    //     return privateFunc();
    // }

    // Internal function call be called inside child contracts.
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }
}


/*
In Solidity, there are four different visibilities that can be used to specify the access level of a contract function or state variable. These are:

public: A public function or state variable can be accessed from anywhere, both internally within the contract and externally from other contracts or accounts. When a function is declared public, a getter function is automatically created that allows other contracts or accounts to read the value of the state variable.

private: A private function or state variable can only be accessed from within the same contract. This means that it cannot be accessed externally from other contracts or accounts.

internal: An internal function or state variable can only be accessed from within the same contract or any contract that inherits from it. This means that it cannot be accessed externally from other accounts or contracts that do not inherit from the same contract.

external: An external function can only be called from outside the contract, and cannot be called internally by other functions within the same contract. external functions are typically used as an interface to allow other contracts or accounts to interact with the contract.

By default, contract functions are public, and state variables are internal. It's important to carefully consider the visibility of each function and state variable in your contract, as it can affect the security, efficiency, and usability of your contract.
 */