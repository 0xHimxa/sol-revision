// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
// be able to raise money 
// if target reached in USD withdraw
// if timer end and goal not reached refund funders thier money 
// bolean that handle it state
 import {PriceConverter} from './lib.sol';


// Custom error definition for gas-efficient error handling
error IncreaseAmount(string _message);

contract RaiseFunds {

    // Using a library for price conversions 
    using PriceConverter for uint256;

    // Minimum funding amount in USD (scaled to 18 decimals)
    uint256 public constant MINIMUM_USD = 5e18;

    // Mapping of project names to their fundraising info
    mapping (string projectname => Fund_Raise_Info) public fundRaisingProjects;

    // Struct representing a funder and their contribution
    struct funders {
        address funder;
        uint256 amount;
    }

    // Struct representing the details of a fundraising project
    struct Fund_Raise_Info {
        string name;                  // Project name
        address payable owner;        // Owner of the project
        uint256 goal;                 // Funding goal
        uint256 deadline;             // Timestamp when project ends
        uint256 totalRaised;          // Total ETH raised so far
        funders[] funder;             // List of all funders
        bool isActive;                // True if project is currently accepting funds
        bool isCompleted;             // True if goal is reached
        bool isRefunded;              // True if funds were refunded
    }

    // Function to create a new fundraising project
    function createproject(string calldata _name, uint256 _goal, uint256 _deadline) public {
        // Get storage reference for the project
        Fund_Raise_Info storage project = fundRaisingProjects[_name];

        // Initialize project details
        project.name = _name;
        project.owner = payable(msg.sender);
        project.goal = _goal;
        project.deadline = block.timestamp + _deadline;
        project.isActive = true;
        project.isCompleted = false;
        project.isRefunded = false;

        // Add the creator as the first funder with 0 contribution
        funders memory funder = funders({funder: msg.sender, amount: 0});
        project.funder.push(funder);

        // Initialize total raised to 0
        project.totalRaised = 0;
    }

    // Function to fund a project
    function fundProject() public payable {
        // Check if sent ETH meets minimum USD requirement
        if (msg.value.converterUSD() < MINIMUM_USD) {
            revert IncreaseAmount('Sent ETH is below minimum requirement');
        }

        // Old require statement (commented out)
        // require(msg.value.converterUSD() > MINIMUM_USD,'please in crease money');

        // Logic to update project funding will go here (not implemented yet)
    }
}








