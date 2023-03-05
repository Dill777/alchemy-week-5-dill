// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Escrow {
	address public arbiter;
	address public beneficiary;
	address public depositor;

	struct Agent {
		uint timestamp;
		uint amount;
	}

	struct User {
        uint256 id;
        address user;
        uint256 amount;
        Agent payments;
    }

	bool public isApproved;

	constructor(address _arbiter, address _beneficiary) payable {
		arbiter = _arbiter;
		beneficiary = _beneficiary;
		depositor = msg.sender;
	}

	event Approved(uint);

	function approve() external {
		require(msg.sender == arbiter);
		uint balance = address(this).balance;
		(bool sent, ) = payable(beneficiary).call{value: balance}("");
 		require(sent, "Failed to send Ether");
		emit Approved(balance);
		isApproved = true;
	}

	mapping (address => mapping(uint => User)) usersList;


	event Usercreated(uint256 _id, address user);
	function createUser(uint _id, uint _amount) external {
		usersList[msg.sender][id] = User(id : _id, user: msg.sender, amount : _amount, payments: Amount({timestamp: block.timestamp, amount:_amount}));
		emit Usercreated(_id, msg.sender);
	}
}
