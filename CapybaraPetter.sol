// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title CapybaraPetter - Pet capybaras onchain on Base
/// @notice Each pet increments the counter. Most pets = Top Capybara Friend!
contract CapybaraPetter {
    uint256 public totalPets;
    address public topPetter;
    uint256 public topPets;

    mapping(address => uint256) public petterPets;
    mapping(address => string) public petterNames;

    event CapybaraPetted(address indexed petter, uint256 totalPets, string name);
    event TopPetterChanged(address indexed newTop, uint256 pets);
    event PetterRenamed(address indexed petter, string newName);

    constructor() {
        totalPets = 0;
    }

    /// @notice Pet a capybara! Increments both the global and your personal counter.
    function petCapybara() external {
        totalPets++;
        petterPets[msg.sender]++;

        if (petterPets[msg.sender] > topPets) {
            topPetter = msg.sender;
            topPets = petterPets[msg.sender];
            emit TopPetterChanged(msg.sender, topPets);
        }

        emit CapybaraPetted(msg.sender, totalPets, petterNames[msg.sender]);
    }

    /// @notice Set your petter name (max 32 chars)
    function setPetterName(string calldata name) external {
        require(bytes(name).length > 0 && bytes(name).length <= 32, "Name: 1-32 chars");
        petterNames[msg.sender] = name;
        emit PetterRenamed(msg.sender, name);
    }

    /// @notice Get a petter's stats
    function getPetterStats(address petter) external view returns (uint256 pets, string memory name, bool isTop) {
        return (petterPets[petter], petterNames[petter], petter == topPetter);
    }
}
