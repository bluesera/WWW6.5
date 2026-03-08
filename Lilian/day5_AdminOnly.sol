// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdiminOnly {
    address public owner;

    constructor(){
        owner = msg.sender;//声明变量，部署了合约就是所有者
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
    _;//检查调用者是不是所有者
    }

    uint256 public treasureAmount;//
    function addTreasure(uint256 amount) public onlyOwner {
    treasureAmount += amount;//函数被调用的时候，宝物会增加
    }

    mapping(address => uint256) public withdrawalAllowance;//用映射记录每个地址被允许提取的数量

    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");//确定额度
        withdrawalAllowance[recipient] = amount;//提取数量
    }

    mapping(address => bool) public hasWithdrawn;

    function withdrawTreasure(uint256 amount) public {
        if (msg.sender == owner) {
        require(amount <= treasureAmount, "Not enough treasury available for this action.");
    treasureAmount -= amount;
        return;//如果调用者是拥有者，拿多少都可以
        }

        uint256 allowance = withdrawalAllowance[msg.sender];
        require(allowance > 0, "You don't have any treasure allowance");//检查是不是被批准
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");//检查是不是已经提取
        require(allowance <= treasureAmount, "Not enough treasure in the chest");//检查宝物够不够

        hasWithdrawn[msg.sender] = true;//标记为已提取
        treasureAmount -= allowance;//减去数量
        withdrawalAllowance[msg.sender] = 0;//将额度重置为0
    }

    function resetWithdrawalStatus(address user) public onlyOwner {
    hasWithdrawn[user] = false;//重置状态

    function getTreasureDetails() public view onlyOwner returns (uint256) {
    return treasureAmount;//可以查看宝箱数量
    }

}