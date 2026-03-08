//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherPiggyBank{
    address public bankManager;//引入经理
    address[] members;//创建数组，保存很多人
    mapping(address => bool) public registeredMembers;//创建映射
    mapping(address => uint256) balance;//记录余额

    constructor() {
     bankManager = msg.sender;
     members.push(msg.sender);//把部署者加入members
    }

    modifier onlyBankManager() {
     require(msg.sender == bankManager, "Only bank manager can perform this action");//只有老大才能用这个函数
     _;
    }

    modifier onlyRegisteredMember() {
     require(registeredMembers[msg.sender], "Member not registered");//只有成员才可以操作钱
     _;
    }

    function addMembers(address _member) public onlyBankManager {
     require(_member != address(0), "Invalid address");//检查地址
     require(_member != msg.sender, "Bank Manager is already a member");//检查有没有重复添加
     require(!registeredMembers[_member], "Member already registered");//是否已经存在

     registeredMembers[_member] = true;
     members.push(_member);//批准加入
    }

    function getMembers() public view returns (address[] memory) {
     return members;//列出成员
    }

    function deposit(uint256 _amount) public onlyRegisteredMember {
     require(_amount > 0, "Invalid amount");
     balance[msg.sender] += _amount;
    }

    function withdraw(uint256 _amount) public onlyRegisteredMember {
     require(_amount > 0, "Invalid amount");
     require(balance[msg.sender] >= _amount, "Insufficient balance");
     balance[msg.sender] -= _amount;
    }
    function depositAmountEther() public payable onlyRegisteredMember {
     require(msg.value > 0, "Invalid amount");
     balance[msg.sender] += msg.value;
    }
}
