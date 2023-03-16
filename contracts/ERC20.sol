
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//An interface is an abstraction of the functions you can interact with, from the contract
interface IERC20 {

    function totalSupply() external view returns (uint); //! Total number of tokens in circulation for a given token contract.

    function balanceOf(address account) external view returns (uint); //! Token balance of a given account/contract

    function transfer(address recipient, uint amount) external returns (bool);//!transfer tokens from the account of the caller (msg.sender) to a specified recipient account.
    //* Remember its only account to account. not to/from smart contracts.

    function allowance(address owner, address spender) external view returns (uint);//! checks the amount of tokens a spender is allowed to spend, that belong to the owner. 

    function approve(address spender, uint amount) external returns (bool);//! msg.sender gives permission to spender to spend "amount"
    //* basically adds it in mapping(address=>mapping(address=>bool))

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);//! sender(3rd party) sends the amount that belongs to owner to reciepient
    //* can be called only after the owner calls approve(), read why above(below approve)

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
}


//example of erc20 token contract. 
//! This is just to understand the flow
contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "Solidity by Example";
    string public symbol = "TOKEN_SYMBOL";
    uint8 public decimals = 18;//amount of full tokens * 10 **18

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}

//! Create Your OWN ERC20