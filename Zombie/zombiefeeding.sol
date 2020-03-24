pragma solidity ^0.4.19;

import "./zombiefactory.sol";

//declaration interface avec la fonction du contrat cryptokitties qui nous interesse et qui retourne plusieurs variables.
contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

    //adresse du contrat cryptokitties
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress); //j'init un kittycontract a cette adresse

  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
    require(msg.sender == zombieToOwner[_zombieId]); //il faut que celui qui appelle la ft soit proprietaire du zombie 
    Zombie storage myZombie = zombies[_zombieId]; //decla d'un zombie en storage, sur la blockchain
    _targetDna = _targetDna % dnaModulus; //verif 16 digits
    uint newDna = (myZombie.dna + _targetDna) / 2; //moyenne
    if (keccak256(_species) == keccak256("kitty")) { //si meme hash, c'est que j'ai mangé un chat. ADN se termine par 99.
        newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); //je set ma variable avec la 10 var returned par getKitty.
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}