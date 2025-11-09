// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


contract ListType{

//to cretae any array we do this similar to type script 

// this means it will be array of numbers

//geting value out is same as js [0] ..

uint256[] num;


// to create our own custom type
// while to create a object we first have to create the type like in ts
// we use struct then name

struct UserInfo{
  string name;
  bool isPaid;


}

// now this how to asign the type to a variable

UserInfo user = UserInfo({name: "john", isPaid: true});

// or
UserInfo userD = UserInfo("john",  true);



// daynami array
//this means it can contain as many val as posible
 UserInfo[] listOfUser;


 //static array

//means it can take max 3 userinfo objects
 UserInfo[3] userList;







}