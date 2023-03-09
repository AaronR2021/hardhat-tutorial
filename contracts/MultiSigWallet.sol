// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

contract MultiSigWallet {
    
    
    //* this contract can recieve ethers
    receive() external payable {}

    //* Holds List of owners. 
    address[] public owners;

    //* Easier to find if its a owner.
    mapping(address=>bool) public isOwner; //we set this in constructor

    //* Number of conformations required
    uint public numConfirmationRequired;

    //* Constructor 
    constructor(address[] memory _owners, uint _numConfirmationsRequired) {
        //check if parameters are correct. 
        require(_owners.length>0,'owners required');
        require(_numConfirmationsRequired>0 &&_numConfirmationsRequired<_owners.length,'Invalid requested conformations');
       
        // sets the owners
        for (uint i = 0; i < _owners.length; i++) {
            //check if address exists in isOwner
            require(!isOwner[_owners[i]],'address already exists');
            //check validity of address
            require(_owners[i]!=address(0),'invalid address');

            //if pass=> here we set all the respective owners
            isOwner[_owners[i]]=true;
            owners.push(_owners[i]);
        }

       //number of conformations required 
       numConfirmationRequired = _numConfirmationsRequired;

    }

    //* ___________________________________
    //! Submit a tx. 

    //* A structure holding information for a transaction.
    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint numConfirmations;
    }

    //* List of transactions. 
    Transaction[] public transactions;

    //* if one of the owners
    modifier onlyOwner() {
        require(isOwner[msg.sender],'Not owner');
        _;
    }

    function submitTransaction(address _to, uint _value, bytes memory _data) public onlyOwner {
       
        transactions.push(Transaction({
                to: _to,
                value: _value,
                data: _data,
                executed: false,
                numConfirmations: 0}));

    }

    //_____________________________________________
    //! Confirm a transaction

    //* how to make sure which owner has agreed to the transaction?
    //* for a given tx.Index we map it to a collecton of addresses who each maps to a bool.
    mapping(uint => mapping(address=>bool)) public isConfirmed;

    modifier txExist(uint _txIndex) {
        require(_txIndex<transactions.length,"tx does not exist");
        _;
    }

    modifier isExec(uint _txIndex) {
        require(!transactions[_txIndex].executed,"already executed");
        _;
    }

    function confirmTransaction(uint _txIndex) public txExist(_txIndex) onlyOwner isExec(_txIndex)  {

        //storage creates a refeence to that transaction. 
        Transaction storage transaction = transactions[_txIndex];

        //increase conformation by 1
        transaction.numConfirmations+=1;

        //saving which owner as agreed to this transaction. 
        isConfirmed[_txIndex][msg.sender]=true;

    }

    //__________________________________________________
    //!  revoke a transaction

        function revokeTransaction(uint _txIndex) public txExist(_txIndex) onlyOwner isExec(_txIndex)  {

        //storage creates a refeence to that transaction. 
        Transaction storage transaction = transactions[_txIndex];


        //if owner had confirmed earlied
        require(isConfirmed[_txIndex][msg.sender],'tx not confirmed');

        //reduce number of conformations
        transaction.numConfirmations-=1;

        //saving which owner as agreed to this transaction. 
        isConfirmed[_txIndex][msg.sender]=false;

    }

    //____________________________________________________
    //!  Execute Tx. 


        function executeTx(uint _txIndex) public onlyOwner txExist(_txIndex) isExec(_txIndex)  {
            Transaction storage transaction = transactions[_txIndex];

            require(transaction.numConfirmations>=numConfirmationRequired,'cannot execute, dont meet requirement');
            transaction.executed=true;

            (bool success,)=transaction.to.call{value:transaction.value}(transaction.data);
            assert(success);
            
            //add emit here to show success
        }

    //______________________________________________________
    //! additional info

        function getOwners() public view returns (address[] memory){
            return owners;
        }

        function getTransactionCount() public view returns (uint) {
            return transactions.length;
        }




}