# Treasure Hunt On-Chain Game

## Overview

Treasure Hunt is an interactive on-chain game built using Solidity. Players compete to find a hidden treasure on a 10x10 grid. The twist? The treasure moves dynamically based on player interactions and a set of predefined rules. The game leverages blockchain technology for transparency, security, and fairness.

## Features

- **10x10 Grid**: The game board consists of 100 unique positions.
- **Dynamic Treasure Movement**: The treasure moves based on player actions, including specific rules for grid positions that are multiples of 5 or prime numbers.
- **Randomness**: Treasure movement is partially randomized using block attributes.
- **Fair Gameplay**: Unit tests ensure that the game is fair and free from exploits.

## Contract Details

- **Language**: Solidity
- **Framework**: Hardhat
- **Blockchain**: Ethereum

## How It Works

1. **Grid Setup**: The game operates on a 10x10 grid. Each position is uniquely identified from 0 to 99.
2. **Player Actions**: Players can move to an adjacent grid position by sending a small amount of ETH.
3. **Treasure Movement**: The treasure moves each time a player moves. Depending on the player's new position, the treasure may move randomly.
4. **Winning Condition**: A player wins by moving to the grid position where the treasure is currently located.
5. **Reward**: The winner receives 90% of the contract’s ETH balance, while 10% is reserved for future rounds.
   
**Core Functions**
**constructor:**
Initializes the grid.
Sets the treasure's initial position using the block hash and block number.

**move(uint8 newPosition):**
Validates the move (checks if it’s adjacent).
Updates the player’s position.
Determines if the player won (i.e., if the player’s new position is the treasure's position).
Moves the treasure according to the rules (prime number, multiple of 5).

**determineWinner():**
Transfers 90% of the contract’s balance to the winner and locks 10% for the next round.

## Installation

### Prerequisites

- [Node.js](https://nodejs.org/)
- [Hardhat](https://hardhat.org/)
- [Ethereum Wallet](https://metamask.io/)

### Steps

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/TreasureHunt.git
    cd TreasureHunt
    ```

2. Install dependencies:

    ```bash
    npm install
    ```

3. Compile the contract:

    ```bash
    npx hardhat compile
    ```

4. Run unit tests:

    ```bash
    npx hardhat test
    ```

5. Deploy the contract:

    ```bash
    npx hardhat run scripts/deploy.js --network your-network
    ```

## Running the Tests

The project includes a set of unit tests to validate the game's logic, including treasure movement, player actions, and the winning condition. Run the tests with:

```bash
npx hardhat test
```

## Usage

Once deployed, players can interact with the contract by sending transactions to move on the grid. The contract handles treasure movement, player actions, and determining the winner.

## Design Considerations

- **Randomness**: The contract uses block attributes like `block.timestamp` and `block.difficulty` to add randomness to treasure movement.
- **Gas Optimization**: Modular arithmetic is used to manage grid movement, minimizing gas costs.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

### Notes:
- Replace `your-username` in the clone command with your actual GitHub username.
- You can adjust the content based on your actual deployment scripts, test cases, and specific instructions for interacting with the contract.
