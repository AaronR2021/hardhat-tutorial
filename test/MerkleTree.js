const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { ethers } = require("hardhat");

//* by default contractFactory() and deploy() are connected to the first signer, i.e "owner"
//* This means the owner account deploys the contract in this test case on the hardhat network.

    //! fixtures help reduce code duplication
    async function deployTokenFixture() {
        //create a object from the contract EthSend.
        //The parameter should be the contract name, and not the file name
        const EthSend = await ethers.getContractFactory("MerkleProof");

        //get owner(who uploaded the contract), address of random user1, address of random user2
        const [owner] = await ethers.getSigners();

        //deploy the contract by pointing to that object.
        const hardhatToken = await EthSend.deploy();
    
        //wait till it gets mined
        await hardhatToken.deployed();
    
        // Fixtures can return anything you consider useful for your tests
        return { EthSend, hardhatToken, owner };
      }


      describe("Merkle Proof", function () {

        it("check if leaf present ", async function () {
            const { hardhatToken, owner } = await loadFixture(deployTokenFixture);
            const proof=["0x8da9e1c820f9dbd1589fd6585872bc1063588625729e7ab0797cfc63a00bd950","0x995788ffc103b987ad50f5e5707fd094419eb12d9552cc423bd0cd86a3861433"];
            const root = "0xcc086fcc038189b4641db2cc4f1de3bb132aefbd65d510d817591550937818c7";
            const ElemntToFind = "0xdca3326ad7e8121bf9cf9c12333e6b2271abe823ec9edfe42f813b1e768fa57b";

            //remember proof is only the sibling nodes to reach the root

           const isPresent = await hardhatToken.verify(proof,root,ElemntToFind,2);
           expect(isPresent).to.equal(true);

         });
       
       });