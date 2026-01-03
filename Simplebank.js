const hre = require("hardhat");

async function main() {
  const SimpleBank = await hre.ethers.getContractFactory("SimpleBank");
  console.log("Deploying SimpleBank...");
  const simpleBank = await SimpleBank.deploy();
  await simpleBank.waitForDeployment();
  console.log("SimpleBank deployed to:", await simpleBank.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
