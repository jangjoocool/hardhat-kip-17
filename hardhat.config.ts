import { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";
import * as dotenv from 'dotenv';

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    baobab: {
      url: process.env.BAOBAB_URL || "",
      accounts: [process.env.PRIVATE_KEY || ""],
      gasPrice: 25000000000,
      chainId: 1001
    },
    klaytn: {
      url: process.env.KLAYTN_URL || "",
      accounts: [process.env.PRIVATE_KEY || ""],
      gasPrice: 25000000000,
      chainId: 8217
    },
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};

export default config;
