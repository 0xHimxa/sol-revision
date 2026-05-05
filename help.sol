// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AdvancedStorage {
    // ---------- ENUM (packs like uint8) ----------
    enum Status { Inactive, Active, Paused, Suspended }
    Status public status;           // Slot 0 (packs with next)
    uint8 public level;              // Slot 0 (same slot)
    uint16 public countdowns;         // Slot 0 (packs here too!)
    
    // ---------- BYTES (dynamic vs fixed) ----------
    bytes32 public constantId;       // Slot 1 (fixed 32 bytes)
    bytes public dynamicData;        // Slot 2 (length at slot 2)
                                     // Data at keccak256(2)
    
    // ---------- STRING (dynamic like bytes) ----------
    string public names;              // Slot 3 (length at slot 3)
                                     // Data at keccak256(3)
    
    // ---------- ARRAY OF STRUCTS ----------
    struct Order {
        uint64 id;                   // First 8 bytes of slot
        uint64 timestamp;            // Next 8 bytes
        address buyer;               // Next 20 bytes (packs partially!)
        bool fulfilled;              // Last 1 byte of slot
        // Total: 8+8+20+1 = 37 bytes -> SPANS 2 SLOTS!
    }
    Order[] public orders;           // Slot 4 (length)
                                     // orders[0] starts at keccak256(4)
                                     // Each Order takes 2 slots
    
    // ---------- MAPPING TO STRUCT ----------
    struct UserProfile {
        uint128 balance;             // Slot keccak256(key . baseSlot)
        uint128 locked;              // Same slot as balance
        uint256 lastActive;           // Next slot (keccak256 + 1)
        uint64 referralCount;        // Same slot as lastActive
        bool isVerified;             // Next slot (keccak256 + 2) - first byte
        // Note: isVerified alone takes full slot due to packing inefficiency
    }
    mapping(address => UserProfile) public users;  // Slot 5
                                                   // Each user takes 3 slots
    
    // ---------- NESTED ARRAY ----------
    uint256[][] public matrix;       // Slot 6 (length of outer array)
                                     // Each inner array: slot = keccak256(6) + i
                                     // Each inner array element: keccak256(innerSlot) + j
    
    // ---------- BIT PACKING IN MAPPING ----------
    mapping(uint256 => uint256) public packedFlags;  // Slot 7
                                                     // Each value stores 256 flags
    
    // ---------- CONSTANT (not stored) ----------
    uint256 public constant VERSION = 1;  // NOT in storage!
    
    // ---------- IMMUTABLE (stored in code, not storage slots) ----------
    address public immutable factory;     // Stored in runtime code, not storage
    
    constructor(address _factory) {
        factory = _factory;
        
        // Initialize enum and packed values
        status = Status.Active;
        level = 5;
        countdowns = 100;
        
        // Fixed bytes32
        constantId = 0x1234567890123456789012345678901234567890123456789012345678901234;
        
        // Dynamic bytes
        dynamicData = hex"deadbeefcafe";
        
        // Dynamic string
        names = "Advanced Contract";
        
        // Array of structs
        orders.push(Order({
            id: 1,
            timestamp: 1234567890,
            buyer: msg.sender,
            fulfilled: false
        }));
        
        orders.push(Order({
            id: 2,
            timestamp: 1234567891,
            buyer:0x742D35Cc6634c0532925a3b844bc9E759F3B3b57,
            fulfilled: true
        }));
        
        // User profile
        users[msg.sender] = UserProfile({
            balance: 1000 ether,
            locked: 500 ether,
            lastActive: block.timestamp,
            referralCount: 10,
            isVerified: true
        });
        
        // Matrix: 2x3
        matrix.push([1, 2, 3]);
        matrix.push([4, 5, 6]);
        
        // Packed flags
        packedFlags[0] = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        packedFlags[1] = 0x1;  // Only bit 0 set
    }
    
    // Helper to get packed flags
    function getFlag(uint256 bucket, uint8 bit) public view returns (bool) {
        return (packedFlags[bucket] >> bit) & 1 == 1;
    }
    
    function setFlag(uint256 bucket, uint8 bit, bool value) public {
        if (value) {
            packedFlags[bucket] |= (1 << bit);
        } else {
            packedFlags[bucket] &= ~(1 << bit);
        }
    }
}