// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => bool) public voters;
    struct Choice {
        uint256 id;
        string name;
        uint256 votes;
    }
    struct Ballot {
        uint256 id;
        string name;
        Choice[] choices;
        uint256 timer;
    }

    mapping(uint256 => Ballot) ballots;
    uint256 nextBallotId;
    address public admin;
    mapping(address => mapping(uint256 => bool)) votes;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can access this feature");
        _;
    }

    function addRegisteredVoters(address[] calldata _voters)
        external
        onlyAdmin
    {
        for (uint256 i = 0; i < _voters.length; i++) {
            voters[_voters[i]] = true;
        }
    }

    function createBallot(
        string memory _name,
        string[] memory _choices,
        uint256 duration
    ) public onlyAdmin {
        ballots[nextBallotId].id = nextBallotId;
        ballots[nextBallotId].name = _name;
        ballots[nextBallotId].timer = block.timestamp + duration;
        for (uint256 i = 0; i < _choices.length; i++) {
            ballots[nextBallotId].choices.push(Choice(i, _choices[i], 0));
        }
        nextBallotId++;
    }

    function vote(uint256 _ballotId, uint256 _choiceId) external {
        require(voters[msg.sender] == true, "Only voters can vote");
        require(
            votes[msg.sender][_ballotId] == false,
            "Voter can vote once per ballot"
        );
        require(
            block.timestamp < ballots[_ballotId].timer,
            "Can only vote while ballot is open"
        );
        votes[msg.sender][_ballotId] = true;
        ballots[_ballotId].choices[_choiceId].votes++;
    }
}
