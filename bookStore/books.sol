
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


contract Books{

 struct Booklend{

 string name;
 string author;
 string lender;
 uint256 id;

 }

mapping(string => Booklend) public booklend;

 Booklend public  user;


 function setBooklend(string memory _name, string memory _author, string memory _lender, uint256 _id) public {

  Booklend  memory lend =  Booklend(_name,_author,_lender,_id);
 
 }



}