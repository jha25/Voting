/** @format */
require("dotenv").config()
const HDWalletProvider = require("@truffle/hdwallet-provider")

const private_keys = [
	process.env.META_KEY,
	process.env.META_KEY2,
	process.env.META_KEY3,
	process.env.META_KEY4,
]

module.exports = {
	networks: {
		development: {
			host: "127.0.0.1",
			port: 8545,
			network_id: "*", // Match any network id
		},
		rinkeby: {
			provider: () =>
				new HDWalletProvider({
					privateKeys: private_keys,
					providerOrUrl: `https://rinkeby.infura.io/v3/${process.env.INFURA_RINKEBY_ID}`,
				}),
			network_id: 4,
			gas: 5500000,
			// confirmations: 2,
			timeoutBlocks: 200,
			skipDryRun: true,
		},
	},
	// Set default mocha options here, use special reporters etc.
	mocha: {
		// timeout: 100000
	},

	// contracts_build_directory: "../frontend/utils",
	compilers: {
		solc: {
			version: "0.8.0", // Fetch exact version from solc-bin (default: truffle's version)
			settings: {
				optimizer: {
					enabled: true,
					runs: 200,
				},
				evmVersion: "byzantium",
			},
		},
	},
}
