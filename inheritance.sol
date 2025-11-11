// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import {SimpleStroge} from './simpleSttorage.sol';



// the is function tell sol to inherite every thing from simple storage

contract addFiveStore is SimpleStroge{

    // to override a function we need to add override to it 
    // then we add virual to the parrent function which is simple storage

function store(uint256 _num) public  override {
 myfavnum = _num + 5;
}

}