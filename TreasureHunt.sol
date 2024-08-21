// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TreasureHunt {
    uint8 public treasurePosition;
    mapping(address => uint8) public playerPosition;
    mapping(address => bool) public hasMoved;
    address public winner;

    event Moved(address player, uint8 newPosition);
    event TreasureMoved(uint8 newTreasurePosition);
    event GameWon(address winner, uint256 reward);

    constructor() {
        treasurePosition = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1)))) % 100);
    }

    function move(uint8 newPosition) external payable {
        require(msg.value >= 0.01 ether, "Minimum ETH required");
        require(newPosition < 100, "Invalid position");
        require(isAdjacent(playerPosition[msg.sender], newPosition), "Must move to adjacent position");
        require(!hasMoved[msg.sender], "Already moved");

        playerPosition[msg.sender] = newPosition;
        hasMoved[msg.sender] = true;

        if (newPosition == treasurePosition) {
            winner = msg.sender;
            distributeReward();
            return;
        }

        if (newPosition % 5 == 0) {
            moveTreasureRandomAdjacent();
        } else if (isPrime(newPosition)) {
            moveTreasureRandom();
        }

        emit Moved(msg.sender, newPosition);
    }

    function isAdjacent(uint8 pos1, uint8 pos2) internal pure returns (bool) {
        return (pos1 == pos2 + 1 || pos1 == pos2 - 1 || pos1 == pos2 + 10 || pos1 == pos2 - 10);
    }

    function moveTreasureRandomAdjacent() internal {
        uint8 direction = uint8(block.timestamp % 4);
        uint8 newTreasurePosition = treasurePosition;

        if (direction == 0 && treasurePosition % 10 != 0) newTreasurePosition--;
        if (direction == 1 && treasurePosition % 10 != 9) newTreasurePosition++;
        if (direction == 2 && treasurePosition >= 10) newTreasurePosition -= 10;
        if (direction == 3 && treasurePosition < 90) newTreasurePosition += 10;

        treasurePosition = newTreasurePosition;
        emit TreasureMoved(treasurePosition);
    }

    function moveTreasureRandom() internal {
        treasurePosition = uint8(uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp))) % 100);
        emit TreasureMoved(treasurePosition);
    }

    function isPrime(uint8 num) internal pure returns (bool) {
        if (num < 2) return false;
        for (uint8 i = 2; i <= num / 2; i++) {
            if (num % i == 0) return false;
        }
        return true;
    }

    function distributeReward() internal {
        uint256 reward = address(this).balance * 90 / 100;
        payable(winner).transfer(reward);
        emit GameWon(winner, reward);
    }
}

