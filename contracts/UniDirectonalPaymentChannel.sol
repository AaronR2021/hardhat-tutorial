
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol"; //we use this for signature verification

import "@openzeppelin/contracts/security/ReentrancyGuard.sol"; //we use this to prevent re-entry attacks
//The ReentrancyGuard library provides a nonReentrant modifier that can be applied to functions in a contract. 
//When the modifier is applied to a function, it prevents the function from being called again until the previous invocation has completed.

contract UniDirectionalPaymentChannel is ReentrancyGuard {
    using ECDSA for bytes32;
    // the above lines means add all the functionalities of ECDSA to the datatype of bytes32. 
    // In other words, we can use the methods provided by ECDSA with bytes32 variables.

    address payable public sender; // who creates the channel, and deposits the initial funds
    address payable public receiver;// address that recieves funds from the channel

    uint private constant DURATION = 7 * 24 * 60 * 60; // how long will the channel be open
    uint public expiresAt;

    constructor(address payable _receiver) payable {
        //we set the address of the person recieving the funds from the contract

        require(_receiver != address(0), "receiver = zero address");
        //* we set the senders address, recievers address and after how long from it being mined will the contract expire
        sender = payable(msg.sender);
        receiver = _receiver;
        expiresAt = block.timestamp + DURATION;
    }

    function _getHash(uint _amount) private view returns (bytes32) {
        // NOTE: sign with address of this contract to 
        //*protect agains replay attack on other contracts

        //* the message that you'll be signing is the amount of ether you'll be paying Bob In this perticular contract/payment channel
        return keccak256(abi.encodePacked(address(this), _amount));
    }

    function getHash(uint _amount) external view returns (bytes32) {
        return _getHash(_amount);
    }

    function _getEthSignedHash(uint _amount) private view returns (bytes32) {
        //* the amount to be sent is hashed. and converted to a format that is ready to be signed on
        return _getHash(_amount).toEthSignedMessageHash();

        /*
        
        first we get the hash of the amount by calling the _getHash() method.
        secondly, we call the toEthSignedMessageHash() method.
            * The toEthSignedMessageHash() method converts the previous hash in a format that we can sign on(It already signes it), 
            * that means using toEthSignedMessageHash() we can later on prove that the above hash belongs to the sender
            * Why?, because it signs the hash input with its private key
            ! [ hash => toEthSignedMessageHash() => hash that is provable that it belongs to msg.sender() ]
        
        */
    }

    function getEthSignedHash(uint _amount) external view returns (bytes32) {
        return _getEthSignedHash(_amount);
    }

    function _verify(uint _amount, bytes memory _sig) private view returns (bool) {
        //* So I get the amount, hash it, sign the hash with the function callers private key,
        //* use recover() and pass the digital signature to get the address of who just signed
        //* this public address that I just got is the address of sender
        return _getEthSignedHash(_amount).recover(_sig) == sender;
    }

    function verify(uint _amount, bytes memory _sig) external view returns (bool) {
        //* The verify function is firstly only called by the reciever, or else it obviously wont work.
        return _verify(_amount, _sig);
    }
//Bob => Alis
    function close(uint _amount, bytes memory _sig) external nonReentrant {
        require(msg.sender == receiver, "!receiver"); //only who I'm sending the money to is allowed to call close()
        require(_verify(_amount, _sig), "invalid sig");

        (bool sent, ) = receiver.call{value: _amount}("");
        require(sent, "Failed to send Ether");
        selfdestruct(sender);//"selfdestruct" has been deprecated
    }

    function cancel() external {
        require(msg.sender == sender, "!sender");
        require(block.timestamp >= expiresAt, "!expired");
        selfdestruct(sender);//"selfdestruct" has been deprecated
    }
}

/*
! explain Uni-directional Payment Channel

* Its a technique used to enable off-chain transactions between two parties. 
* Off-chain transactions are transactions that occur outside of the main blockchain network.
* This allows for faster and cheaper transactions. 
* In a uni-directional payment channel, only one party can send funds to the other party

*/

/*
! NOTE: The above contract does not have a function to sign the amount.
 */