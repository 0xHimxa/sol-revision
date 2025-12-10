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
    //bytes can not encode multiple string
        return bytes('hello world');
    }


//note for encodePacked and bytes we can just typecast to string and it will decode it
//this encode below only for for abi.encode



//we can use it for what is in bytes form

function decode() external pure returns (string memory){
// the decode fn from abi accept two input one is the item we want to
//decode the other is to which type: eg string so we can read it

string memory world = abi.decode(combineString(),(string));

return world;
}


function multiEncode() public pure returns(bytes memory){
bytes memory name = abi.encode('hello world','i am himxa');
return name;

}


function multiDecode() external pure returns(string memory,string memory){
//since we encode to string  to acces the two value we do it like below

(string memory world,string memory intro) = abi.decode(multiEncode(),(string,string));

return(world,intro);


}


// some more low level stuff
 
 // call: how we can chaing the state of a blocchian;

 // delegatecall: how we can change the state of a blockchain with another contract;
 
 // staticcall: how we can read the state of a blockchain;


 function withdraw( address winner) external returns(bool){
    // in the place we use call to populate the value field of the transaction the amount to be sent
    // while if we pass in daata in () to call a specific function
    (bool success,) = winner.call{value: address(this).balance}("");
    return success;
 }


}