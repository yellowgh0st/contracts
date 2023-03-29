import { HardhatUserConfig } from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'
import '@nomiclabs/hardhat-etherscan'
import '@openzeppelin/hardhat-upgrades'

import secret from './secret'

const config: HardhatUserConfig = {
  solidity: "0.8.9",
	networks: {
    goerli: {
      url: secret.networks.goerli.url,
      accounts: [secret.privateKey],
			gasPrice: 10015095859,
    },
	},
	etherscan: {
    apiKey: secret.etherscanKey,
  },
}

export default config
