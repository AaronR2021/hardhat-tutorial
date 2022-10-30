const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

//TODO: To execute this test case run [npx hardhat test test/Counter.js]
//! ofcourse not the "[]" part :), Just the text 

describe("Counter contract", function () {

    it("Counter initial value", async function () {
        //* ethers.getSigners() holds a list of accounts on the hardhat network, owner is who owns the contract.
        //* ethers is a global scope object, so you dont have to worry about importing it.
        const [owner] = await ethers.getSigners();
        //* getContractFactory returns an abstraction that we use to deploy the contract.
        const CounterContract = await ethers.getContractFactory("Counter");
        //* .deploy() deploys the contract,
        //* and returns a object that has all the methods you possess in your smart contract
        const CounterContractDeployed = await CounterContract.deploy();
    
        const returnedCounter = await CounterContractDeployed.get()
        expect(returnedCounter).to.equal(0);
      });


      it("Counter increment value", async function () {
        //* ethers.getSigners() holds a list of accounts on the hardhat network, owner is who owns the contract.
        //* ethers is a global scope object, so you dont have to worry about importing it.
        const [owner] = await ethers.getSigners();
        //* getContractFactory returns an abstraction that we use to deploy the contract.
        const CounterContract = await ethers.getContractFactory("Counter");
        //* .deploy() deploys the contract,
        //* and returns a object that has all the methods you possess in your smart contract
        const CounterContractDeployed = await CounterContract.deploy();
    
        await CounterContractDeployed.inc()
        const returnedPCounter = await CounterContractDeployed.get()
        expect(returnedPCounter).to.equal(1);
      });

      it("Counter decrement value", async function () {
        //* ethers.getSigners() holds a list of accounts on the hardhat network, owner is who owns the contract.
        //* ethers is a global scope object, so you dont have to worry about importing it.
        const [owner] = await ethers.getSigners();
        //* getContractFactory returns an abstraction that we use to deploy the contract.
        const CounterContract = await ethers.getContractFactory("Counter");
        //* .deploy() deploys the contract,
        //* and returns a object that has all the methods you possess in your smart contract
        const CounterContractDeployed = await CounterContract.deploy();


        //! First, we increase by one
        await CounterContractDeployed.inc()
        expect(await CounterContractDeployed.get()).to.equal(1);

        //! then, we decrease by one
        await CounterContractDeployed.dec()
        expect(await CounterContractDeployed.get()).to.equal(0);

        //! The reason being since count is a uint datatype it cannot take in negitive numbers.
        //! we could use this test case in the code itself, but we'll get to that later
      });

});
