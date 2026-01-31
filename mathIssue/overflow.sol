//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;



//*///////////////////////////////////
            //OVERFLOW

    ///////////////////////////////*//


    contract OverFlow{





uint8 public count;

// the max value of uint8 is 255
// if use use this unchecked key word  if it reach it max and we add again it will reset
// but if we didnot use it and it reach it max  and we try to increase it , it will revert which is much better


function increase(uint8 amount) public{

unchecked{
    count = count + amount;
}
}
}


    