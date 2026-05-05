// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StorageV2 {
    // Same beginning as V1
    uint256 public version;
    
    
               // slot 0 - same


    // We  remname it and swap it
    uint256 public lessImportantValue;
    address public owner;            
   

    // New order that changes layout
    uint256 public newBigValue;       

    bool public paused;
    uint8 public counter;               
  
    uint16 public smallNumber;       
  uint256 public extraData;  
    string public name;               

    mapping(address => uint256) public balances;   // slot 5

    constructor() {
        version = 2;
        owner = msg.sender;
        newBigValue = 999999;
        extraData = 123456789;
        name = "Storage Version 2 - Modified Layout";
        balances[msg.sender] = 1000;
    }

    function setExtraData(uint256 _data) external {
        extraData = _data;
    }
}