// SPDX-License-Identifier: GPL-3.0;
pragma solidity 0.8.0;

contract Lottery {
    address payable[] public players;
    address public owner_mgr;
    
    constructor(){
        owner_mgr = msg.sender;  
// Challenge 2 Solution
        //players.push(payable(owner_mgr)); 
    }
    
    receive() external payable{
        require(msg.value == 0.1 ether );
// Challenege 1 Solution
        //require(msg.sender!=owner_mgr);
        
        players.push(payable(msg.sender));
    }

    function getBalance()public view returns (uint){
        require(msg.sender==owner_mgr);
        return address(this).balance;
    }

    function random_gen() public view returns (uint){
        require(msg.sender==owner_mgr);
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function pick_winner() public returns(address){
        require(msg.sender==owner_mgr);
        require(players.length>=3);

// Challenge 3 Solution
        //REMOVE MANAGER CHECK FROM pick_winner.
        //require(players.length>=10);

        uint r = random_gen();
        address payable winner;

        uint indi = r % players.length;
        winner = players[indi];

// Challenge 4 Solution
      //uint managerFee = (getBalance() * 10) / 100;
      //uint winnerAmt = (getBalance() * 90) / 100;
      //payable(owner_mgr).transfer(managerFee);
      //winner.transfer(winnerAmt);

        winner.transfer(getBalance());
        players = new address payable[](0);
        return winner; 
    }
}
