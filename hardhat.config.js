require("@nomiclabs/hardhat-waffle");
require('dotenv').config();
const fs = require('fs')
const privateKey = fs.readFileSync('.secret').toString();


// task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
// 	const accounts = await hre.ethers.getSigners();

// 	for (const account of accounts) {
// 		console.log(account.address);
// 	}
// });

const projectId = process.env.PROJECT_ID

module.exports = {
  networks: {
    hardhat: {
      chainId: 1337
    },
    mumbai: {
      url: `https://polygon-mumbai.infura.io/v3/${projectId}`,
      accounts: [privateKey]
    },
    mainnet: {
      url: `https://mainnet.infura.io/v3/${projectId}`,
      accounts: [privateKey]
    }
  },
	solidity: "0.8.4",
};
