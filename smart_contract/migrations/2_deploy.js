/** @format */

const Voting = artifacts.require("Voting")

module.exports = async function (deployer, _network, accounts) {
	await deployer.deploy(Voting)
	const voting = await Voting.deployed()
	await voting.addRegisteredVoters([accounts[1], accounts[2], accounts[3]])
	await voting.createBallot(
		"Who should be President?",
		["Trump", "Biden", "Bernie"],
		120,
	)
}
