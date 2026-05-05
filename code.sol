// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {AdvancedStorage} from "./help.sol";

contract StorageV1 is AdvancedStorage {
    // Slot 0
    uint256 public version;           // 32 bytes → slot 0
    address public owner;             // 20 bytes

    // Slot 1 (packed with above if possible, but uint256 took full slot)
    uint256 public importantValue;    // slot 1

    // Slot 2
    bool public paused;               // 1 byte
    uint8 public counter;             // 1 byte
    uint16 public smallNumber;        // 2 bytes
    // remaining bytes in slot 2 are unused

    // Slot 3
    string public name;               // dynamic → starts at slot 3, data at keccak256(3)

    // Slot 4
    mapping(address => uint256) public balances;   // mapping → slot 4 used for hashing

    constructor()AdvancedStorage(address(300)) {
        version = 1;
        owner = msg.sender;
        importantValue = 1000;
        name = "Storage Version 1";
    }

    function setImportantValue(uint256 _newValue) external {
        importantValue = _newValue;
    }
}