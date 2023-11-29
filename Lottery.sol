// SPDX-License-Identifier: GPL-3.0;
pragma solidity 0.8.0;

contract Lottery {
    address payable[] public players;
    address public owner_mgr;
    
    constructor(){
        owner_mgr = msg.sender;  
    }
    
    receive() external payable{
        require(msg.value == 0.1 ether );
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

        uint r = random_gen();
        address payable winner;

        uint indi = r % players.length;
        winner = players[indi];

        winner.transfer(getBalance());
        players = new address payable[](0);
        return winner; 
    }
}
