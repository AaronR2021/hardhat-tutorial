// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
*submit trx.
*approval/rejetion of trx.
*execute after enough approval
*/

/*
*list of owners
*no of approval per transaction
*/

contract MultiSigNew {

    receive() external payable {}
    //list of owners
    address[] public owner;

    uint8 public numberOfCheckers;
    //check if address is owner
    mapping (address => bool) isOwner;

    constructor(address[] memory _owners,uint8 _numberOfApproval) {

        require(_owners.length>=_numberOfApproval,"in correct number of approvals");


        for (uint i = 0; i < _owners.length; i++) {
            //check if does not exists
           require(!isOwner[_owners[i]]==true,'already added this owner');
           require(_owners[i]!=address(0),'incorrect address format');

           //add to checked
           isOwner[_owners[i]]=true;

           //add to owner list
           owner.push(_owners[i]);
        }
        numberOfCheckers=_numberOfApproval;
    }

    //!submit transaction
    //*define a transaction -> when defining a struct(";")
    struct Transaction {
        address to;
        bytes data;
        uint noOfApprovals;
        bool isApproved;
        uint amount;
    }

    //List of pending transactions
    Transaction[] public transactions;

    //for each address
    mapping(uint => mapping(address=>bool)) public transactionApprovalList;



    function submitTrx(address _to,bytes memory dataValue,uint _amount) public{

        //*Check if owner
        require(isOwner[msg.sender]==true);

        //*When using a struct =>(",")
        transactions.push(
            Transaction({
            to:_to,
            amount:_amount,
            data:dataValue,
            noOfApprovals:1,
            isApproved:false
        })
        );

        transactionApprovalList[transactions.length-1][msg.sender]=true;
        
    }

    //!approve transaction

    function approveTrx(uint _transactionId) public{

        //check is already approved
        require(transactionApprovalList[_transactionId][msg.sender]==false,"already approved/rejected");


        Transaction storage transaction = transactions[_transactionId];
        transaction.noOfApprovals+=1;

        transactionApprovalList[_transactionId][msg.sender]=true;

    }

    //!reject transaction
    function rejectTrx(uint _transactionId) public{

        //check is already approved
        require(transactionApprovalList[_transactionId][msg.sender]==false,"already approved/rejected");


        Transaction storage transaction = transactions[_transactionId];
        transaction.noOfApprovals-=1;

        transactionApprovalList[_transactionId][msg.sender]=true;

    }

    //!execute transaction
    function executeTrx(uint _trxId) public {
        Transaction storage transaction = transactions[_trxId];

        require(transaction.noOfApprovals>=numberOfCheckers,"failed to meet criteria");

        (bool success,)=transaction.to.call{value:transaction.amount}(transaction.data);
        assert(success);
        transaction.isApproved=true;
    }
    




}