// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;


contract CallAnything{

address public s_addre;
uint256 public s_val;


function transfer(address addre,uint256 val) public {

   s_addre = addre;
   s_val =val;

   

}


function getSelector() public pure returns(bytes4  selector){


// the val we put inside the kec is the signature
// the val stored in the selectore is the fn selectore somthing like: 0xsfff;
//this tell sol to call that sepcific fn

selector = bytes4(keccak256(bytes("transfer(address,uint256)")));

return selector;

}


function getDataToCallTransfer(address _to,uint256 _amount) public pure returns(bytes memory data){
// this place  we encode the slector with the arg it accepts
return abi.encodeWithSelector(getSelector(), _to,_amount);

}


function callTransferFunctionDirectly(address _to, uint256 _amount) public returns(bytes4,bool){

    (bool success,bytes memory returnData) = address(this).call(
        //this 

//getDataToCallTransfer(address(32),1 ether)

//or we just do it direct in here
abi.encodeWithSelector(getSelector(), _to,_amount)

    );




    // the returndata is the data the function returns after it been called

    return(bytes4(returnData), success);
}

 
// encode with sig do same thing for us we just pass in the sig

function callTransferFunctionDirectlySig(address _to, uint256 _amount) public returns(bytes4,bool){

    (bool success,bytes memory returnData) = address(this).call(
        //this 

//getDataToCallTransfer(address(32),1 ether)

//or we just do it direct in here
abi.encodeWithSignature("transfer(address,uint256)", _to,_amount)

    );




    // the returndata is the data the function returns after it been called

    return(bytes4(returnData), success);
}


}