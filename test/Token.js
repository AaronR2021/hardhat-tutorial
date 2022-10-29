const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("Token contract", function () {
 //!: First test
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    //* ethers.getSigners() holds a list of accounts on the hardhat network, owner is who owns the contract.
    //* ethers is a global scope object, so you dont have to worry about importing it.
    const [owner] = await ethers.getSigners();

    //* getContractFactory returns an abstraction that we use to deploy the contract.
    const Token = await ethers.getContractFactory("Token");

    //* .deploy() deploys the contract,
    //* and returns a object that has all the methods you possess in your smart contract
    const hardhatToken = await Token.deploy();

    const ownerBalance = await hardhatToken.balanceOf(owner.address);

    //* variable that is mentioned as public, is called as a function(), e.g=> totalSupply
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });

 //!: Second Test
 it("Should transfer tokens between accounts", async function() {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("Token");

    const hardhatToken = await Token.deploy();

    // Transfer 50 tokens from owner to addr1
    await hardhatToken.transfer(addr1.address, 50);
    expect(await hardhatToken.balanceOf(addr1.address)).to.equal(50);

    // Transfer 50 tokens from addr1 to addr2
    await hardhatToken.connect(addr1).transfer(addr2.address, 50);
    expect(await hardhatToken.balanceOf(addr2.address)).to.equal(50);
  });


});

//! by default contractFactory() and deploy() are connected to the first signer, i.e "owner"
//! This means the owner account deploys the contract in this test case on the hardhat network.

    //! fixtures help reduce code duplication
    async function deployTokenFixture() {
        const Token = await ethers.getContractFactory("Token");
        const [owner, addr1, addr2] = await ethers.getSigners();
    
        const hardhatToken = await Token.deploy();
    
        await hardhatToken.deployed();
    
        // Fixtures can return anything you consider useful for your tests
        return { Token, hardhatToken, owner, addr1, addr2 };
      }


      describe("Token contract-load fixtures", function () {
        //!: First test
         it("Deployment should assign the total supply of tokens to the owner", async function () {
            const { hardhatToken, owner } = await loadFixture(deployTokenFixture);

           const ownerBalance = await hardhatToken.balanceOf(owner.address);
       
           //* variable that is mentioned as public, is called as a function(), e.g=> totalSupply
           expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
         });
       
        //!: Second Test
        it("Should transfer tokens between accounts-fixtures", async function() {
            const { hardhatToken, owner, addr1, addr2 } = await loadFixture(
                deployTokenFixture
              );
       
           // Transfer 50 tokens from owner to addr1
           await hardhatToken.transfer(addr1.address, 50);
           expect(await hardhatToken.balanceOf(addr1.address)).to.equal(50);
       
           // Transfer 50 tokens from addr1 to addr2
           await hardhatToken.connect(addr1).transfer(addr2.address, 50);
           expect(await hardhatToken.balanceOf(addr2.address)).to.equal(50);
         });
       
       
       });