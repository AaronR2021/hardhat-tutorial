const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("Mapping contract", async function () {
  it("Mapping get", async function () {
    const [owner] = await ethers.getSigners();

    const MappingContract = await ethers.getContractFactory("Mapping");
    const MappingContractDeployed = await MappingContract.deploy();

    const value1 = await MappingContractDeployed.get(owner.address);
    await MappingContractDeployed.set(owner.address,100);

    const value2 = await MappingContractDeployed.get(owner.address);
    await MappingContractDeployed.remove(owner.address);

    const res = await MappingContractDeployed.get(owner.address);

    expect(value1).to.equal(10);
    expect(value2).to.equal(100);
    expect(res).to.equal(0);
  });

});
