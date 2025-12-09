// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


contract Encoding{

//string.concat allow as to join string like been done below


//the bytes is computer readable code stuff like 0xgfuub...
//abi.encode and packed, can join string and covert them to bytes 
// so we have to convert them back to string so we can read it

    function combineString() public pure returns(bytes memory){
        return abi.encode('hello world');
    }


 function combineStrigEncode() external pure returns(bytes memory){
        return abi.encodePacked('hello world');
    }
// byte type casting do similar with encodePacked check the diiff ask Ai

 function combineStrigBytes() external pure returns(bytes memory){
        return bytes('hello world');
    }

//we can use it for what is in bytes form

function decode() external pure returns (string memory){
// the decode fn from abi accept two input one is the item we want to
//decode the other is to which type: eg string so we can read it

string memory world = abi.decode(combineString(),(string));

return world;
}



}