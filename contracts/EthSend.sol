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
    //recieve should always be external, as its never called within the contract.  
    receive() external payable{}
    

    //the withdraw function is external is its not called within the contract
    function withdraw(uint _amount) external {
        require(msg.sender==owner,"You dont have owner previlage");

        require(_amount<=address(this).balance,"Insufficient funds");

        (bool send,)=owner.call{value:_amount }(""); //_amount is in wei, no aditional data hence ("")

        assert(send); //if false throw error
        //we could use require(), but the reasons we didnt choose require is as follows
        //! the odds of send being true is wayyy more than being false,
        //! Its not a user defined parameter
        //! require uses more gas than assert

        //* require is used for external input validation, can be expensive for gas consumption,
        //* assert is used for internal consistency checks and is typically less expensive in terms of gas consumption.
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


/*
 As you might have noticed that most of the functions are declared as external, instead of public. now why is that?
 if your want to use that function from within and outside the function, use public.
 if yuo want to modify the state of the blockchain use public. 

 but if you dont use it within the contract or only read the state variables, use external

 external uses less gas compared to public

 */