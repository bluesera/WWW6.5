// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract PollStation {
    string[] public candidateNames;//声明一个数组存姓名
    mapping(string=>uint256) voteCount;//创建映射跟踪票数

    function addCandidateNames(string memory_candidateNames) public {
        candidateNames.push(_candidateNames);//将姓名存储到数组
        voteCount[_candidateNames]=0;//初始化票数为零
    }

    function getCandidateNames() public view returns (string[] memory){
        return candidateNames;//允许查看谁在投票
    }

    function vote(string memory_candidateNames) public {
        voteCount[_candidateNames] += 1;//候选人票数加一
    }

    function getVote(string memory _candidateNames) public view returns (uint256)
    {
        return voteCount[_candateNames];//从映射检索票数
    }
}