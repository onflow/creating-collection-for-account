// Pass the repo name
const recipe = "creating-collection-for-account";

//Generate paths of each code file to render
const contractPath = `${recipe}/cadence/contract.cdc`;
const transactionPath = `${recipe}/cadence/transaction.cdc`;

//Generate paths of each explanation file to render
const smartContractExplanationPath = `${recipe}/explanations/contract.txt`;
const transactionExplanationPath = `${recipe}/explanations/transaction.txt`;

export const creatingCollectionForAccount = {
  slug: recipe,
  title: "Creating Collection For Account",
  createdAt: new Date(2022, 9, 14),
  author: "Flow Blockchain",
  playgroundLink:
    "https://play.onflow.org/41befd2d-31f3-47f0-ae30-aad776961e31?type=tx&id=88850298-bed1-4bb9-b77e-4df200f76278&storage=none",
  excerpt:
    "Create a new collection for an existing Flow account that doesn't have one so that it can store your NFTS in it.",
  smartContractCode: contractPath,
  smartContractExplanation: smartContractExplanationPath,
  transactionCode: transactionPath,
  transactionExplanation: transactionExplanationPath,
  filters: {
    difficulty: "beginner"
  }
};
