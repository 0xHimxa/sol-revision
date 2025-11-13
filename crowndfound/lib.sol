// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";



library PriceConverter{



function getEthPriceUSD() internal view returns(uint256){

AggregatorV3Interface price_data = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

(,int256 price,,,) = price_data.latestRoundData();

return uint256(price )* 1e10;

}


function converterUSD( uint256 _ethamount)internal view returns(uint256){

uint256 price = getEthPriceUSD();

 uint256 convert = (price * _ethamount)/1e18;

 return convert;
}




}