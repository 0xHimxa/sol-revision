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


// solidity version lower thatn 0.8.0 we dont need to add the unchecked 
//if it reached it max it will revert it self


function increase(uint8 amount) public{

unchecked{
    count = count + amount;
}
}
}



//////////////////////////////////////
            //  UNDERFLOW

//////////////////////////////

    


    contract UnderFlow{





uint8 public count;



// the max value of uint8 is 255
// if use use this unchecked key word  if it reach it min and we add again it will reset
// but if we didnot use it and it reach it min and we try to increase it , it will revert which is much better



function decrease() public{

unchecked{
    count --;
}
}
}