// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

const hre = require("hardhat");
async function deployDiamond() {

  // const diamondCutFacet = await deployContract("Diamond");
  let diamondCutFacet = { address: "0xc5a5C42992dECbae36851359345FE25997F5C42d" };
  diamondCutFacet = await hre.ethers.getContractAt('Diamond', diamondCutFacet.address)

  let facets = ["facet1", "facet2", "Company", "Student"];
  let cut = []
  let selectors = []
  for (let i = 0; i < facets.length; i++) {
    const deployedContract = await deployContract(facets[i]);
    const abi = hre.artifacts.readArtifactSync(facets[i]).abi;
    const selector = getFunctionSelectors(abi);
    selectors = [...selectors, ...selector];
    cut.push({
      contractAddress: deployedContract?.target,
      contractBytes: selector
    })
  }
  console.log(cut); // Logs the list of function selectors
  let tx = await diamondCutFacet.addFunctions(cut);
  console.log(tx?.hash); // Logs the transaction hash for the addFunctions call
}


if (require.main === module) {
  deployDiamond()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error)
      process.exit(1)
    })
}

exports.deployDiamond = deployDiamond


async function deployContract(contractName) {
  const DiamondCutFacet = await hre.ethers.getContractFactory(contractName)
  const diamondCutFacet = await DiamondCutFacet.deploy();
  console.log("deployed-contract:", contractName, diamondCutFacet?.target);
  return diamondCutFacet;
}


function getFunctionSelectors(abi) {
  const functionSelectors = abi
    .filter(item => item.type === 'function') // Filter only function types
    .map(item => {
      const signature = `${item.name}(${item.inputs.map(input => input.type).join(",")})`;
      return ethers.keccak256(ethers.toUtf8Bytes(signature)).substring(0, 10); // Get the first 4 bytes
    });

  return functionSelectors;
}

// npx hardhat run --network localhost .\ignition\modules\Dimond.js //to deploy