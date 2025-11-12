
// we want to be able to recive money and be able to withdraw
// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import{PriceConverter} from "./lib.sol";
// this i a fn from chainLink that will be providing us with realtime price of coin


contract Fundme{
  // this mean all unit256 will have access to our priceconverter libra
  // it will automatically pass it sel in only wen it accept 2 input that wen we type the other in
  using PriceConverter for uint256;

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







}