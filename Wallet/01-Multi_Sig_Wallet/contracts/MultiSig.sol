// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract MultiSigWallet {
    uint public MAX_SIGNER = 50;
    uint public threshold;
    address[] public signer;

    mapping(uint => Proposal) public proposals;
    mapping(uint => mapping(address => bool)) public confirmations;

    struct Proposal {
        address destination;
        uint value;
        bytes data;
        bool executed;
    }

    modifier validThreshold(uint totalNum, uint threshold) {
        require(totalNum <= MAX_SIGNER && totalNum >= threshold && totalNum > 0);
        _;
    }

    constructor(address[] memory _signers, uint _threshold) validThreshold(_signers.length, _threshold) {
        for(uint i=0; i<_signers.length; i++){
            require(_signers[i] != address(0), "Invalid 0x0 Address");
        }
        signer = _signers;
        threshold = _threshold;
    }

    function addProposal(address destination, uint value, bytes memory data) public returns (uint) {
        uint transactionId = addTransaction(destination, value, data);
        confirmTransaction(transactionId);
        return transactionId;
    }



    receive() external payable {}

    fallback()external {}
}

