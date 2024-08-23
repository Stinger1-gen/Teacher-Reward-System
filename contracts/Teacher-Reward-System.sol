// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract TeacherRewardSystem {
    // Struct to hold teacher details
    struct Teacher {
        uint id;
        string name;
        address walletAddress;
        uint rewardPoints;
    }

    // Mapping to store teachers by ID
    mapping(uint => Teacher) public teachers;
    uint public nextTeacherId;

    // Address of the contract owner
    address public owner;

    // Event for logging when rewards are distributed
    event RewardDistributed(uint teacherId, uint amount);

    // Modifier to restrict functions to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
        nextTeacherId = 1;
    }

    // Function to add a new teacher
    function addTeacher(string memory _name, address _walletAddress) public onlyOwner {
        teachers[nextTeacherId] = Teacher(nextTeacherId, _name, _walletAddress, 0);
        nextTeacherId++;
    }

    // Function to distribute rewards to a teacher
    function distributeReward(uint _teacherId, uint _amount) public onlyOwner {
        require(_teacherId > 0 && _teacherId < nextTeacherId, "Invalid teacher ID");
        teachers[_teacherId].rewardPoints += _amount;
        emit RewardDistributed(_teacherId, _amount);
    }

    // Function to fund the contract with ether
    function fundContract() public payable onlyOwner {}

    // Function to get the balance of the contract
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Fallback function to handle ether sent to the contract
    fallback() external payable {}

    receive() external payable {}
}

