// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


//over here we deploy simplestorgr in another contract
//firt import it over her

import {SimpleStroge} from '../simpleSttorage.sol';






contract StorageFactory{

// now let first create a value that store it

 SimpleStroge[] public listofsimpleStorage;
 
uint256 public how;
uint256 wow;

 // now we create a fn that deploy it

 function deploySimpleStorage() public{

//  the new keyword tell sol we want to deploy then we call the contract like fn
   SimpleStroge newSimoleStoreage = new SimpleStroge();

   // now this line add the deploed contract info and addres to the list above
   listofsimpleStorage.push(newSimoleStoreage);




 }


 function sfStore(uint256 _index, uint256 _favnum)public {

    // to interact with a contract we need it ABI and addrees whihc both are pushed to the listofsimplestorage
   SimpleStroge getSimplestorage = listofsimpleStorage[_index];
   getSimplestorage.store(_favnum);

 }

function sfRetrive(uint256 _index)public view  returns(uint256) {
 SimpleStroge getSimplestorage = listofsimpleStorage[_index];
  return getSimplestorage.retrived();
}
}

