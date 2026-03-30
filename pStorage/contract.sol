// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StorageLab {
    // Slot 0: Packing Test
    // These three should all fit into ONE 32-byte slot.
    // 16 bytes + 8 bytes + 4 bytes = 28 bytes total.
    uint128 public a = 0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA; 
    uint64  public b = 0xBBBBBBBBBBBBBBBB;
    uint32  public c = 0xCCCCCCCC;

    // Slot 1: Long String vs Short String Test
    // Start with a short string (under 31 bytes).
    string public description = "Short"; 

    // Slot 2: Dynamic Array Test
    // Slot 2 stores the length. Data starts at keccak256(2).
    uint256[] public scores;

    // Slot 3: Nested Mapping Test
    // allowance[owner][spender] = amount
    mapping(address => mapping(address => uint256)) public allowance;

    // Slot 4: Struct in Mapping with Packing
    struct User {
        uint128 balance; // 16 bytes
        uint128 points;  // 16 bytes (Packs with balance into 1 slot)
        uint256 id;      // 32 bytes (New slot)
    }
    mapping(address => User) public users;

    constructor() {
        scores.push(100);
        scores.push(200);
    }

    // --- Helper Functions for your Tests ---

    function setLongString() public {
        description = "This is a very long string that will definitely trigger the long storage strategy!";
    }

    function setAllowance(address spender, uint256 amount) public {
        allowance[msg.sender][spender] = amount;
    }

    function setUser(address addr, uint128 bal, uint128 pts, uint256 _id) public {
        users[addr] = User(bal, pts, _id);
    }
}