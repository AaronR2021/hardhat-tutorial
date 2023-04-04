// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC721 {

function safeTransferFrom(address from, address to, uint tokenId) external;
function transferFrom (address,address,uint) external;
        
}

contract EnglishAuction {
//just adding this command here, this contract is able to recieve ethers. 
//recieve should always be external, as its never called within the contract.  
receive() external payable{}

IERC721 public nft; //all IERC721 functions mentioned in the interface can be used with the above. 
uint public nftId; //Id of the NFT

address payable public seller; //address of who is selling. 

uint public endAt;
bool public started;
bool public ended;

address public highestBider; //address of the highest bidder
uint public highestBid;      // highest amount that is bid for the nft.
mapping(address=>uint) public bids; //map the address to the amount of the bid

constructor(address _nft, uint _nftId, uint _startingBid){
    nft = IERC721(_nft);
    nftId=_nftId;
    highestBid=_startingBid;
    seller=payable(msg.sender);
}

function start() external {
    require(!started,'already started');
    require(msg.sender==seller,'not authorized');

    endAt=block.timestamp + 7 days; // block.timestamp refers to the timestamp of the current block on the Ethereum blockchain
    started=true;
    nft.safeTransferFrom(msg.sender,address(this),nftId); //I'm transfering the nft to the current contract. 

}

function bid() payable external { //Its payable coz we are dealing with money
    require(started,'not yet started');
    require(block.timestamp<endAt,"ended");

    if(bids[msg.sender]>0){ //we check if the sender has already paid before 

        bids[msg.sender]+=msg.value; //if yes we add its value to the previous value

        if(bids[msg.sender]>highestBid){ //we check if the added value is higher than the highestBid
            highestBider=msg.sender;
            highestBid=msg.value;
        }
    }
    else{
        require(msg.value>highestBid,"should be higher than the current bid");
            highestBider=msg.sender;
            highestBid=msg.value;
            bids[msg.sender]=msg.value;
    }
}


function withdraw() external { //previous participants can withdraw their funds
require(bids[msg.sender]>0,'you have no bids on this NFT');
uint bal = bids[msg.sender];
bids[msg.sender]=0;
payable(msg.sender).transfer(bal);//transfer the amount back to the biders

}

function end() external { //deals with the transfer of nft
    require(started,'Not started');
    require(!ended,'Not ended');
    require(block.timestamp>endAt,'time for Austion has expired');

    ended=true;

    if(highestBider!=address(0)){
        //means someone paid an amount
        seller.transfer(highestBid);//move the funds to the owners account
        nft.safeTransferFrom(address(this),highestBider,nftId);//transfer nft
        bids[highestBider]=0;//reset the bids of that perticular owner;
    }else{
        //nobody bought the nft
        nft.safeTransferFrom(address(this),seller,nftId);//send the nft back to creator
    }


}












}





//? English Auction For NFT's

//!Auction
//* Seller of NFT Deploys this Contract
//* Auction Lasts for 7 days
//* Participants can bit by depositing ETH greater than the current Highest bidder
//* All bidders can withdraw their bid if it is not the current Highest Bid. 

//!After Auction
//* Highest bidder becomes the new owner of the NFT. 
//* The Seller recieves the highest bid by ETH.