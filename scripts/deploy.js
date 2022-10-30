//! Hello-World
async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("owners with account address:   ", deployer.address);
  
    console.log("Your(*owner*) account balance on hardhat network:   ", (await deployer.getBalance()).toString());
  
   // const Token = await ethers.getContractFactory("Hello-World");
    const Token = await ethers.getContractFactory("Counter");
    const token = await Token.deploy();
  
    console.log("Contract deployed Address:   ", token.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });