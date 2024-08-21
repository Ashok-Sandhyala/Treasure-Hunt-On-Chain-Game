const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TreasureHunt", function () {
    let treasureHunt, owner, addr1, addr2;

    beforeEach(async function () {
        [owner, addr1, addr2] = await ethers.getSigners();
        const TreasureHunt = await ethers.getContractFactory("TreasureHunt");
        treasureHunt = await TreasureHunt.deploy();
        await treasureHunt.deployed();
    });

    it("Should initialize the treasure position", async function () {
        const pos = await treasureHunt.treasurePosition();
        expect(pos).to.be.within(0, 99);
    });

    it("Should allow a player to move to an adjacent position", async function () {
        await treasureHunt.connect(addr1).move(1, { value: ethers.utils.parseEther("0.01") });
        const pos = await treasureHunt.playerPosition(addr1.address);
        expect(pos).to.equal(1);
    });

    it("Should move the treasure on a valid prime number move", async function () {
        await treasureHunt.connect(addr1).move(7, { value: ethers.utils.parseEther("0.01") });
        const pos = await treasureHunt.treasurePosition();
        expect(pos).to.be.within(0, 99).and.not.equal(7);
    });

    it("Should declare a winner and distribute rewards", async function () {
        // Assume treasure is at position 1
        await treasureHunt.connect(addr1).move(1, { value: ethers.utils.parseEther("0.01") });
        expect(await treasureHunt.winner()).to.equal(addr1.address);
        const balance = await ethers.provider.getBalance(addr1.address);
        expect(balance).to.be.gt(ethers.utils.parseEther("0.01"));
    });
});
