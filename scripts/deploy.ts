import { ethers, upgrades, run } from 'hardhat'
import { log } from 'console'

const main = async () => {

	const DrippsFactory = await ethers.getContractFactory('DrippsEventFactory')
  const DrippsEvent = await ethers.getContractFactory('DrippsEvent')

	if (false) {
		const dropNonce = await DrippsEvent.deploy({ nonce: 9 })
	}
	else {
		const drippsFactory = await upgrades.deployProxy(DrippsFactory,
			undefined,
			{
				kind: 'uups',
		})
		const drippsProxy = await drippsFactory.deployed()
		await log(`DrippsProxy deployed to ${drippsProxy.address}`)

		const drippsFactoryImplementation = await upgrades.erc1967.getImplementationAddress(drippsProxy.address)
		await log(`DrippsFactory deployed to ${drippsFactoryImplementation}`)

		const drippsEvent = await DrippsEvent.deploy()
		await log(`DripsEvent deployed to ${drippsEvent.address}`)
		
		const drippsEventProxied = await DrippsFactory.attach(drippsProxy.address)
		await drippsEventProxied.eventImplementation_set(drippsEvent.address)
		await log(`New Event Implementation set to ${drippsEvent.address}`)

		await run('verify:verify', { address: drippsProxy.address })
		await run('verify:verify', { address: drippsEvent.address })
	}

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
