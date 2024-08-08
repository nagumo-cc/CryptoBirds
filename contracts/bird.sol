// contracts/BirdMarketplace.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BirdMarketplace {
    struct Bird {
        uint id;
        string name;
        address owner;
        uint price;
    }

    Bird[] public birds;
    mapping(uint => address) public birdToOwner;
    mapping(address => uint) ownerBirdCount;

    event BirdCreated(uint id, string name, address owner, uint price);
    event BirdBought(uint id, address newOwner, uint price);

    function createBird(string memory _name, uint _price) public {
        uint id = birds.length;
        birds.push(Bird(id, _name, msg.sender, _price));
        birdToOwner[id] = msg.sender;
        ownerBirdCount[msg.sender]++;
        emit BirdCreated(id, _name, msg.sender, _price);
    }

    function buyBird(uint _id) public payable {
        require(_id < birds.length, "Bird does not exist");
        Bird storage bird = birds[_id];
        require(msg.value >= bird.price, "Not enough Ether");
        require(bird.owner != msg.sender, "You already own this bird");

        address previousOwner = bird.owner;
        bird.owner = msg.sender;
        ownerBirdCount[previousOwner]--;
        ownerBirdCount[msg.sender]++;
        birdToOwner[_id] = msg.sender;

        payable(previousOwner).transfer(msg.value);
        emit BirdBought(_id, msg.sender, bird.price);
    }

    function getBirds() public view returns (Bird[] memory) {
        return birds;
    }
}
