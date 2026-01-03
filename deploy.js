const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();

    console.log("Deploying contracts with account:", await deployer.getAddress());

    const Calculator = await hre.ethers.getContractFactory("Calculator");
    const calculator = await Calculator.deploy();
    await calculator.waitForDeployment();
    console.log("Calculator deployed to:", calculator.target);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
