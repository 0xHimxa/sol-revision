// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.28;


// the transient keyword those not support  mapping, dynamic bytes or array, fixed sized array, all dont not support structs and enum

// it only support basic types like , uint/int, bool, address, bytes 2 - bytes32 


contract TransStorage{

//mapping (address => mapping(address => uint256)) transient flashAllowance;



struct UserSeasions{
    address  user;
    uint256 startTime;
    bool isActive;
} 

 //UserSeasions transient currentUser;


 bool transient acctive;

function grantFlashAllowance(address spender,uint256 amount) external{
//  flashAllowance[msg.sender][spender] = amount;


}








}

