const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { ethers } = require("hardhat");

//* by default contractFactory() and deploy() are connected to the first signer, i.e "owner"
//* This means the owner account deploys the contract in this test case on the hardhat network.

    //! fixtures help reduce code duplication
    async function deployTokenFixture() {
        //create a object from the contract EthSend.
        //The parameter should be the contract name, and not the file name
        const EthSend = await ethers.getContractFactory("MultiSigNew");

        //get owner(who uploaded the contract), address of random user1, address of random user2
        const [owner, addr1, addr2] = await ethers.getSigners();

        //deploy the contract by pointing to that object.
        const contractObject = await EthSend.deploy();
    
        //wait till it gets mined
        await contractObject.deployed();
    
        // Fixtures can return anything you consider useful for your tests
        return {contractObject, owner, addr1, addr2 };
      }


      describe("Ether Wallet", function () {

        it("initial funds present in the contract", async function () {
            const { hardhatToken, owner } = await loadFixture(deployTokenFixture);

            //*Initial funds in the contract
           const contractBalance = await hardhatToken.getBalance();
           expect(contractBalance).to.equal(0);

         });

         it("owner value not address(0)", async function () {
            const { hardhatToken, owner,addr1 } = await loadFixture(deployTokenFixture);

            //*Initial funds in the contract
           const ownerAddress = await hardhatToken.owner();
           expect(ownerAddress).to.not.equal(0x0000000000000000000000000000000000000000);

         });

         it("check if you recieve ether in this contract", async function () {
            const { hardhatToken, addr1} = await loadFixture(deployTokenFixture);

            //address of contract
            const addressOfContract = await hardhatToken.getAddressContract();

            //send money to address of contract
            const params = { to: addressOfContract, value: ethers.utils.parseUnits("2.472", "ether").toHexString()};
            const txHash = await addr1.sendTransaction(params);

           //balance the contract holds
           const contractBalance = await hardhatToken.getBalance();
           expect(contractBalance).to.not.equal(0);




         });
         
         it("check if owner can withdraw ether from this contract by checking the balance of the contract", async function () {
            const { hardhatToken, owner, addr1} = await loadFixture(deployTokenFixture);

            //address of contract
            const addressOfContract = await hardhatToken.getAddressContract();

            //send money to address of contract
            const params = { to: addressOfContract, value: ethers.utils.parseUnits("2.472", "ether").toHexString()};
            const txHash = await addr1.sendTransaction(params);

//            console.log(ethers.BigNumber.from("2472000000000000000"),"convert string to bignumber")
//            console.log(await hardhatToken.getBalance(),' is the balance')
//            console.log(ethers.BigNumber.from("2472000000000000000")<=await hardhatToken.getBalance())

           //owner withdraws funds
           await hardhatToken.withdraw(ethers.BigNumber.from("1472000000000000000"));

           //balance of contract
           expect(await hardhatToken.getBalance()).to.equal(ethers.BigNumber.from("1000000000000000000"))

         });
       
       
       });