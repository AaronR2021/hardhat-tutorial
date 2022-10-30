const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

//TODO: To execute this test case run [npx hardhat test test/Hello-World.js]
// ofcourse not the "[]" part :), Just the text 

describe("HelloWorld contract", function () {
  it("Checking the Hello-World contract", async function () {
    //* ethers.getSigners() holds a list of accounts on the hardhat network, owner is who owns the contract.
    //* ethers is a global scope object, so you dont have to worry about importing it.
    const [owner] = await ethers.getSigners();

    //* getContractFactory returns an abstraction that we use to deploy the contract.
    //! Important Notice: Although the contract name is Hello-World we have specified it as HelloWorld,
    //! This is because when compiling, the compiler gets rid of the - and joins the words toegther.
    //! you can go onto the artifacts > contracts folder and notice the contract name changed there after compilation.
    const HelloWorldContract = await ethers.getContractFactory("HelloWorld");

    //* .deploy() deploys the contract,
    //* and returns a object that has all the methods you possess in your smart contract
    const HelloWorldContractDeployed = await HelloWorldContract.deploy();

    //* variable that is declared public, is called as a function(), e.g=> greet()
    const returnedGreet = await HelloWorldContractDeployed.greet()

    //* Obviously this is not your address since its just a test :). 
    //* but otherwise it would be yourse
    console.log('Address of the owner who owns the contract',owner.address)

    expect(returnedGreet).to.equal('Hello World');
  });

});
