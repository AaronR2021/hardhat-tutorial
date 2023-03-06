const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("ifElse contract", function () {
  it("run the ifElse condition", async function () {

    const [owner] = await ethers.getSigners();

    const IfElseContract = await ethers.getContractFactory("IfElse");
    const IfElseContractDeployed = await IfElseContract.deploy();

    const value1 = await IfElseContractDeployed.foo(5);
    const value2 = await IfElseContractDeployed.ternary(10);

    console.log('Address of the owner who owns the contract',owner.address)

    expect(value1).to.equal(0);
    expect(value2).to.equal(1);
  });

});
