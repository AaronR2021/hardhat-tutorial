//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract EthWallet{
    //this address can hold funds now
    address payable public owner;

    constructor(){
        //owner address asigned
        owner = payable(msg.sender);
    }

    //just adding this command here, this contract is able to recieve ethers.  
    receive() external payable{}
    

    function withdraw(uint _amount) external {
        require(msg.sender==owner,"You dont have owner previlage");

        require(_amount<=address(this).balance,"Insufficient funds");

        (bool send,)=owner.call{value:_amount }(""); //_amount is in wei

        assert(send); //if false throw error
    }

    //balance of the contract
    function getBalance() external view returns (uint){
       return address(this).balance ; //this will return values in wei
    }

    //address of contract
    function getAddressContract() view public returns (address) {
        return address(this);
    }
}

/*
? This contract is about the follows:

! anyone can send ETH to this contract;
! only owner can retrieve eth from this contract to his address;

*/

