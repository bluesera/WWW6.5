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
}