pragma solidity 0.8.0;

contract Auction {

    struct Bid{
        address bidder_address;
        uint bid_amount;
        uint bid_date;
    }

    address manager;

    uint public deadline;
    mapping(address=>Bid) public bidders;
    mapping(uint=>address) public bidder_by_no;
    uint[] public bid_array;
    mapping(address=>bool) public isBid;
    uint public counter;

    constructor(uint _lastdate) {
        manager=msg.sender;
        deadline=block.timestamp+_lastdate;
    }

    modifier  onlyManager() {
        require(msg.sender==manager,"only manager can call this function");
        _;
    }

    

    function bid(uint _amount1) public {
        
        require(block.timestamp <= deadline,"auction time is over");
        require(!isBid[msg.sender],"you already bid");
        bidders[msg.sender]=Bid(msg.sender,_amount1,block.timestamp);
         bidder_by_no[counter]=msg.sender;
         bid_array.push(_amount1);
         isBid[msg.sender]=true;
         counter++;

    }

    function getResult()  public view  onlyManager  returns(address)
    {
        require(block.timestamp >=deadline,"you can call this function after auction deadline");
        uint highbid;
        address winner;

        for(uint i=0;i<bid_array.length;i++)
        {
            if(bid_array[i] > highbid) {
                highbid = bid_array[i]; 
                winner=bidder_by_no[i];
            } 
        }
         return winner;
        
    }


}
