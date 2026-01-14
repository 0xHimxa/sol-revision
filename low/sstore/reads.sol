// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract accessStoreIndex{
uint256 age =33;
bool isStudent =true;
uint256 ageMarried= 25;



function showPacking() public view returns(bytes memory slot0, bytes memory slot1,uint256 ageReturend){

    assembly{
    slot0 := sload(0)
    slot1 := sload(1)
    }


ageReturend = 4;




}

// we can treive the value base on how we do below compare to abovw where i  am converting the value to bytes

function debugStorage() public view returns (
    uint256 slot0,
    uint256 slot1,
    uint256 slot2,
    uint256 decodedFromSlot0
) {
    assembly {
        slot0 := sload(0)
        slot1 := sload(1)
        slot2 := sload(2)
    }
    
    decodedFromSlot0 = abi.decode(abi.encode(slot0), (uint256)); // same as direct cast
    
    return (slot0, slot1, slot2, decodedFromSlot0);
}



}