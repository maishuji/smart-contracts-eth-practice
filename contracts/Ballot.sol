//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Ballot{
    struct Voter{
        uint weight;
        bool voted;
        uint8 vote;
    }

    struct Proposal {
        uint voteCount;
    }

    address chairPerson;
    mapping (address => Voter) voters;
    Proposal[] proposals;

    // Construct a Ballot with n proposals
    constructor(uint8 _numProposals) {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 2;
        
        // Init the proposals to 0
        Proposal memory zeroProp;
        zeroProp.voteCount = 0;
        for(uint idxProp = 0; idxProp < _numProposals; ++idxProp ){
            proposals.push(zeroProp);
        }
    }

    // Must be register by chairPerson
    function register(address toVoter) public {
        if(msg.sender != chairPerson || voters[toVoter].voted)return;
        voters[toVoter].weight = 1;
        voters[toVoter].voted = false;
    }

    function vote(uint8 toProposal) public {
        // storage keyword : Data stored persistently on the Eth. blockchain
        // stored in contract's storage
        // Expensive to read/write because it involves operations on the blockchain
        Voter storage sender = voters[msg.sender];
        if(sender.voted || toProposal >= proposals.length)return;
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; ++prop) {
            if( proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
        }
    }







}