# 🔐 Overview of Multi-sig Wallets

---

**Languages**: [English](./README.md) | [中文](./README_zh.md)

---

## 🌐 Origin of Multi-signature Technology
Multi-signature (multi-sig) technology originates from cryptographic "Threshold Signatures," a concept introduced long before blockchain technology. Threshold signatures allow multiple keys to participate in the signing process, requiring a certain number of keys (i.e., a threshold) for the signature to be validated. This technology was initially used in banking and financial institutions to authorize high-risk transactions or safeguard essential assets.

*Application in Bitcoin* - With the advent of Bitcoin and blockchain technology, multi-sig was integrated into blockchain wallets to enhance fund management security. Bitcoin was one of the earliest blockchain projects to implement multi-sig functionality. On the Bitcoin blockchain, an “n-of-m” multi-sig scheme can manage a wallet, e.g., a 3-of-5 multi-sig requires 3 out of 5 keys to initiate a transaction. The Bitcoin protocol supports this multi-sig mechanism through the OP_CHECKMULTISIG opcode.

## 🔐 Steps in Multi-signature Process
1. Define the list of signers and threshold (n-of-m): The smart contract stores an array of authorized signer addresses and a threshold variable.
2. Proposal submission and approval process: Interactors of the multi-sig wallet first submit a transaction proposal in the smart contract, and other signers can sign this proposal by calling a specific function. Each signature is recorded on-chain.
3. Verify the number of signatures: When the required number of signatures is met, the smart contract automatically executes the transaction, either sending funds or calling another contract.

## 🔑 Key Functions
1. Proposal submission function: This function allows users to submit a transaction proposal to the contract, including the target address, amount, and other parameters.
2. Approval function: Signers can call this function to approve a transaction proposal, and the contract records the signer’s approval.
3. Execution function: Once the proposal has received enough signatures, the contract completes the transaction or operation via this function.
4. Status query function: To help users check the status of transactions, the contract generally includes query functions to display the current signature count and the number of signatures still needed.

## 🚨 Security and Safeguards
1. Replay protection: Each transaction proposal has a unique ID or nonce to prevent duplicate submissions or replay attacks.
2. Access control: Only signers defined by the contract can approve transaction proposals, preventing unauthorized users from taking malicious actions.
3. Time lock: Some multi-sig wallets implement a time lock, requiring a proposal to undergo a "cooling period" before execution, reducing the risk of errors or malicious actions under urgent conditions.

## 🚫 Limitations
1. Transaction costs: Every signature and proposal operation consumes gas, and costs increase significantly as the number of signatures grows.
2. Complexity: Multi-sig logic can be complex, and any mistakes in implementation may lead to security vulnerabilities.

## 📝 Applications
1. Bitcoin's multi-sig schemes
2. Gnosis Safe contract wallet on EVM, widely used in DAOs and DeFi projects.
3. Chains like Cosmos and Polkadot also implement multi-sig functionality for community fund management and project governance.

---

## 📚 References

### Open Source Code
- **Gnosis Multi-sig Wallet** - [Gnosis Multi-sig Wallet v0.4.x (Solidity)](https://github.com/gnosis/MultiSigWallet)
- **Gnosis Safe Contract** - [Gnosis Safe (Latest Version)](https://github.com/safe-global/safe-contracts)

### Related Resources
