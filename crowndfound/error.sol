// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

error Cantdabyzero(string);
contract practiceError{


uint256 number;

function addnum(uint256 _num) external{
  if(_num == 0) {
    revert Cantdabyzero("cant  increse by zerro");
  } 

  number += _num;
}


}