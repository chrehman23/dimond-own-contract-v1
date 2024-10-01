// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

const hre = require("hardhat");
async function deployDiamond() {
  // let diamondCutFacet = await deployContract("Diamond");
  diamondCutFacet = await hre.ethers.getContractAt('Diamond', "0x9A9f2CCfdE556A7E9Ff0848998Aa4a0CFD8863AE")

  let facets = ["Products"];
  let cut = []
  let selectors = []
  for (let i = 0; i < facets.length; i++) {
    const deployedContract = await deployContract(facets[i]);
    const abi = hre.artifacts.readArtifactSync(facets[i]).abi;
    console.log("************************************************************************************************")
    const selector = getFunctionSelectors(abi);
    console.log("************************************************************************************************")
    selectors = [...selectors, ...selector];
    cut.push({
      contractAddress: deployedContract?.target,
      contractBytes: selector
    })
  }
  console.log({ cut }); // Logs the list of function selectors
  let tx = await diamondCutFacet.addFunctions(cut);
  const res = await tx.wait();
  console.log(res?.hash)
  // const test = await hre.ethers.getContractAt('Products', "0x5FbDB2315678afecb367f032d93F642f64180aa3")
  // let tx2 = await test.getSig();
  // console.log("Deployed all facets:", tx?.hash, tx2); // Logs the transaction hash for the addFunctions call
  console.log("diamond Address:", diamondCutFacet.target); // Logs the transaction hash for the addFunctions call
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
  console.info("deployed-contract:", contractName, diamondCutFacet?.target);
  return diamondCutFacet;
}


function getFunctionSelectors(abi) {
  const functionSelectors = abi
    .filter(item => item.type === 'function') // Filter only function types
    .map(item => {
      const signature = `${item.name}(${item.inputs.map(input => {
        if (input.internalType.includes("struct")) {
          return "(" + input.components.map(comp => comp.type).join(",") + ")";
        }
        return input.type;
      }).join(",")})`;
      console.log(signature);
      let functionSelect = ethers.keccak256(ethers.toUtf8Bytes(signature)).substring(0, 10)
      console.info(signature, "=>", functionSelect);
      return functionSelect;
    });
  functionSelectors.push("0x315ef1f9")
  console.log(functionSelectors)
  return functionSelectors;
}

const funString = (item) => {
  if (item?.inputs?.components) {
    return funString(item?.inputs?.components)
  }
  const signature = `${item.name}(${item.inputs.map(input => input.type).join(",")})`;
  return signature
}

// npx hardhat run --network localhost ./deploy/Dimond.js //to deploy