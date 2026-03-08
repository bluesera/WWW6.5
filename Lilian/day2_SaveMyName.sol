//SPDX-Licsense-Identifier:MIT
pragma solidity ^0.8.0;

contract SaveMyName{
     string name;
     string bio;//存储信息

     function add (string memory_name,string memory_bio) public {
        name=_name;//add函数：存储数据
        bio=_bio;//状态变量变成了参数
     }
     function retrieve()public view returns(string memory,string name) {
        return(name,bio);//此为检索函数
     }

     
}