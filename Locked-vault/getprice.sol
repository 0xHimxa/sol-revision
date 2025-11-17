// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library Price_getter{
function getEthprice() internal view returns(uint256){
 AggregatorV3Interface returned_priced = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
 (, int price,,,) = returned_priced.latestRoundData();

 return  uint256(price)* 1e10;

}


function convert_eth_USD(uint256 _amount) internal view returns (uint256){

uint256 price = getEthprice();

return (price * _amount)/1e18;

}

}