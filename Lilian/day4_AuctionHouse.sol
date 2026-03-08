 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {
    address public owner;//追踪操作者
    string public item;//竞拍之物品
    uint public auctionEndTime;//定义持续的时间
    address private higgestBid;//存储最高价
    uint private higgestBid;//出价人之地址
    bool public ended;

    mapping(address => uint) public bids;//记录出价
    address[] public bidders;//记录价格

    constructor(string memory _item, uint _biddingTime) {
    owner = msg.sender;//保存为所有者
    item = _item;//物品的名称
    auctionEndTime = block.timestamp + _biddingTime;
    }
    
    function bid(uint amount) external {
    require(block.timestamp < auctionEndTime, "Auction has already ended.");//用require设置规则
    require(amount > 0, "Bid amount must be greater than zero.");
    require(amount > bids[msg.sender], "New bid must be higher than your current bid.");

    if (bids[msg.sender] == 0) {
        bidders.push(msg.sender);//是不是新的竞标者
    }

    bids[msg.sender] = amount;//保存出价

    if (amount > highestBid) {
        highestBid = amount;
        highestBidder = msg.sender;//更新最高出价和出价者
    }
}

function endAuction() external {
    require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");//检查拍卖时间
    require(!ended, "Auction end already called.");//确保没有被结束
    ended = true;
}

function getWinner() external view returns (address, uint) {
    require(ended, "Auction has not ended yet.");//返回获胜者
    return (highestBidder, highestBid);
}

}

