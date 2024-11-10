// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract MultiSigWallet {
    uint public MAX_SIGNER = 50;
    uint public threshold;
    address[] public signer;

    mapping(uint => Proposal) public proposals;
    mapping(uint => mapping(address => bool)) public signatures;


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

    modifier validProposal(uint proposalId) {
        require(transactionExists(transactionId));
        _;
    }

    constructor(address[] memory _signers, uint _threshold) validThreshold(_signers.length, _threshold) {
        for(uint i=0; i<_signers.length; i++){
            require(_signers[i] != address(0), "Invalid 0x0 Address");
        }
        signer = _signers;
        threshold = _threshold;
    }

    function isAgree(uint proposalID) public view returns(bool){
        uint counter = 0;
        for(uint i =0; i< signer.length; i++){
            if(signatures[proposalID][signer[i]]){
                counter++;
            }
        }
        if(counter >= threshold){
            return true;
        }else{
            return false;
        }
    }

    function addProposal(address destination, uint value, bytes memory data) public returns (uint) {
        uint transactionId = addTransaction(destination, value, data);
        confirmTransaction(transactionId);
        return transactionId;
    }


        function external_call(address call_address, uint value, uint dataLen, bytes memory data) internal returns (bool result) {
        assembly {
            let x := mload(0x40)
            let d := add(data, 32)
            result := call(
            gas(),
            call_address,
            value,
            d,
            dataLen,
            x,
            0
            )
        }
    }
    receive() external payable {}

    fallback()external {}
}
