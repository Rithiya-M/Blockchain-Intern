import { ethers } from "hardhat";

async function main() {
  const DeFiLending = await ethers.getContractFactory("DeFiLending");

  const defi = await DeFiLending.deploy();
  await defi.waitForDeployment();   // ✅ NEW way

  const address = await defi.getAddress();
  console.log("DeFi Lending deployed to:", address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
