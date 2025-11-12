
// we want to be able to recive money and be able to withdraw
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import{PriceConverter} from "./lib.sol";
// this i a fn from chainLink that will be providing us with realtime price of coin


contract Fundme{
  // this mean all unit256 will have access to our priceconverter libra
  // it will automatically pass it sel in only wen it accept 2 input that wen we type the other in
  using PriceConverter for uint256;

  address owner;

// constructer is a fn that is been called righ wen the contruct is deployed

constructor(){
  owner = msg.sender;
}










//adderss of funders

address[] public funders;

mapping ( address => uint256) public addressToAmountFunded;




// the payable keyword tell eth that we are going to recive money 
function fundme() public payable {









  // allow users to send $
  // have menimu amount

uint256 minimum = 5e18;

// the msg.value let us know how much the user is sending
  //msg.value;


// the require is use to set minimum like how we do it below, and we added error message

//msg.value is a uint so it have asse to our priceconver lib
  require(msg.value.getConvertionRate() > minimum,'please increase the value');

  addressToAmountFunded[msg.sender] += msg.value;
  funders.push(msg.sender);

//revert note if the require faild any operation that was been done in the function will un do it self back

}


function withdraw()public{
// first we need to create a loop to recent the amount founders send back to zero


//note looping is not a good idea in solidity, it not gas efficient
for(uint256 index = 0;index < funders.length; index++){

  address founder = funders[index];
   addressToAmountFunded[founder] = 0;
}

funders = new address[](0);


// to widthdraw funds from  contract we use
//transfer  if failde it revert the tx
payable(msg.sender).transfer(address(this).balance);

//send // if faild it dont revert the tx we have to specify it, it return bool we done
bool success = payable(msg.sender).send(address(this).balance);
//if it false it will triger the require
require(success,'transfer failed');


//call same with send but this on return to varable so we destructur it
(bool callsuccess,)= payable(msg.sender).call{value:address(this).balance}('');

require(callsuccess,'transfer failed');










}





}