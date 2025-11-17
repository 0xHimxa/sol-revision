// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Price_getter} from './getprice.sol';

contract Lock_Vault{
using Price_getter for uint256;

 uint256 public constant  lock_time = 1 minutes;
 uint256 public constant minimum_lock_USD = 1e18;

struct Vault{

    uint256 amount;
    uint256 unlock;
    address payable owner;
}

mapping ( address => Vault[]) public vault;


function lock_token( uint256 _unlock)external payable{

require(msg.value.convert_eth_USD() >  minimum_lock_USD, "Minimum lock amount is 1 USD");
 
 if(_unlock == 0){
    _unlock = lock_time;
 }
 vault[msg.sender].push(Vault({
    amount: msg.value,
    unlock: _unlock,
    owner: payable(msg.sender)
}));




}

function unLock_Token() external{

require(vault[msg.sender].length > 0, 'you dont have anytoken looked');


for(uint256 i = vault[msg.sender].length; i > 0 ; i--){
uint256 index = i - 1;
 Vault[]  storage amount = vault[msg.sender];
 if(amount[index].unlock <= block.timestamp){
   (bool success,) = payable(msg.sender).call{value:amount[index].amount}('');

   require(success, "transaction failed");
 
 uint256 lastElementIndex = vault[msg.sender].length - 1;

   if(index != lastElementIndex){

    amount[index] = amount[lastElementIndex];
   }
   amount.pop();
 }

}


}




}