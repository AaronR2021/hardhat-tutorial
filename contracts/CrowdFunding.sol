// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface IERC20{ //entry point to access the IERC20 tokens
    function transfer(address,uint) external returns (bool); //transfer the tokens
    function transferFrom(address,address,uint) external returns (bool); 
}

contract CrowdFund {

    struct Campaign{
        address creator; //creator of campaign
        uint goal;      //Amount of tokens to raise
        uint pledged;   //Total amount pledged
        uint32 startAt; //TimeStamp of start of campaign
        uint32 endAt;   //Timestamp of end of campaign
        bool claimed;   //true if goal was reached
    }

    mapping (uint => Campaign) campaigns;
    IERC20 public immutable token;
    uint public count; //count is total number of campaigns

    //for this given campaign ,this user paid X amount
    mapping (uint => mapping(address=>uint)) public pledgedAmount;

    constructor(address _token){
        token=IERC20(_token);
    }
    //TODO: functions

    function launch(uint _goal,uint32 _startAt, uint32 _endAt)external{
        require(_startAt>=block.timestamp,"start should be eq. or gr than current block time");
        require(_endAt>=_startAt,"end should be eq. or gr than start date");
        require(_endAt>=_startAt + 9 days,"end should be gr. than start + duration");

        count+=1; //increase campaign count by 1;
        //below: for that given Id(Count) we associate this campaign
        campaigns[count]=Campaign({
            creator:msg.sender,
            goal:_goal,
            pledged:0,
            startAt:_startAt,
            endAt:_endAt,
            claimed:false
        });
    }


    //!delete a campaign if it hasnt started yet
    function cancle(uint _id)external{
        Campaign memory campaign=campaigns[_id]; //we need this to check who made this campaign. as only the creator can delete it
        require(campaign.creator==msg.sender,'Not authorised');
        require(campaign.startAt>block.timestamp,"campaign has already started");

        delete campaigns[_id];//deletes this perticular campaign associated to the _id;

    }

    //! pledge an amount in a campaign that has started. 
    function pledge(uint _id,uint _amount)external{
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp>campaign.startAt,"Campaign has not started yet");
        require(block.timestamp<campaign.endAt,"Campaign has ended");

        campaign.pledged+=_amount;
        //for this given campaign ,this user paid X amount
        pledgedAmount[_id][msg.sender]=_amount;
        //from sender to contract: amount
        token.transferFrom(msg.sender,address(this),_amount);

    }

    //!take back the amount you pledged for a certain campaign. 
    function unPledge(uint _id,uint _amount)external{
        Campaign memory campaign = campaigns[_id];
        require(pledgedAmount[_id][msg.sender]<=_amount, "insufficient amount");

        //*make changes to the amount you have withdrawn back
        pledgedAmount[_id][msg.sender]-=_amount;

        //*reduce the amount from the respective campaign
        campaign.pledged-=_amount;
        token.transfer(msg.sender, _amount);

    }

    //! the owner of the campaign can claim the funds
    function claim(uint _id)external{
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged < campaign.goal, "pledged >= goal");

        uint bal = pledgedAmount[_id][msg.sender];//only owner can claim the funds

        pledgedAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender, bal);
    }

    //! the individual people who funded the campaign can take the funds
    function refund(uint _id)external{
        
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged < campaign.goal, "pledged >= goal");

        uint bal = pledgedAmount[_id][msg.sender];
        pledgedAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender, bal);
    }

}