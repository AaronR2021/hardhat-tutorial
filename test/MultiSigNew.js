const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { ethers } = require("hardhat");

    //! fixtures help reduce code duplication
    async function deployTokenFixture() {

        const [owner, addr1, addr2] = await ethers.getSigners();

        const EthSend = await ethers.getContractFactory("MultiSigNew");

        const contractObject = await EthSend.connect(owner).deploy([owner.address,addr1.address,addr2.address],2);
    
        //wait till it gets mined
        await contractObject.deployed();
    
        // Fixtures can return anything you consider useful for your tests
        return {contractObject, owner, addr1, addr2 };
      }


      describe("MultiSig Wallet", function () {

        it("connection-check", async function () {
            const { contractObject } = await loadFixture(deployTokenFixture);

            //*Initial funds in the contract
           const value = await contractObject.getInfo();
           expect(value).to.equal(2);

         });

         it("submit transaction", async function(){
            const {contractObject, owner, addr1, addr2} = await loadFixture(deployTokenFixture);

            await contractObject.submitTrx(addr2.address,1);

         })
         it("approve transaction", async function(){
            const {contractObject, owner, addr1, addr2} = await loadFixture(deployTokenFixture);

            //*send some money to a contract
            const tx = await owner.sendTransaction({
                to: contractObject.address,
                value: ethers.utils.parseEther("5"),
              });
          
              // Wait for the transaction to be mined
              await tx.wait();
          
              // Check that the contract balance has increased by 1 ether
              const balance = await ethers.provider.getBalance(contractObject.address);
              expect(balance).to.equal(ethers.utils.parseEther("5"));//sending 5 ether            
            await contractObject.submitTrx(addr2.address,2000000000000000000n);

            const addr1Trx = contractObject.connect(addr1)
            const addr2Trx = contractObject.connect(addr2)

            await addr1Trx.approveTrx(0);
            await addr2Trx.approveTrx(0);

            await contractObject.executeTrx(0)
            const balanceNew = await ethers.provider.getBalance(contractObject.address);
            expect(balanceNew).to.equal(3000000000000000000n)
            

         })

         it("reject transaction", async function(){
            const {contractObject, owner, addr1, addr2} = await loadFixture(deployTokenFixture);

            //*send some money to a contract
            const tx = await owner.sendTransaction({
                to: contractObject.address,
                value: ethers.utils.parseEther("5"),
              });
          
              // Wait for the transaction to be mined
              await tx.wait();
          
              // Check that the contract balance has increased by 1 ether
              const balance = await ethers.provider.getBalance(contractObject.address);
              expect(balance).to.equal(ethers.utils.parseEther("5"));//sending 5 ether            
              await contractObject.submitTrx(addr2.address,2000000000000000000n);

            const addr1Trx = contractObject.connect(addr1)
            const addr2Trx = contractObject.connect(addr2)

            await addr1Trx.rejectTrx(0);
            await addr2Trx.rejectTrx(0);

            await expect(contractObject.executeTrx(0)).to.be.revertedWith("failed to meet criteria");
         })
       
       
       });