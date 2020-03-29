pragma solidity >=0.4.19;

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

   KittyInterface kittyContract;

  //cette ft ne pourra etre appelée que par l'owner meme si elle est external. 
  //On fait cela pour pouvoir changer l'adresse du contrat krypto en cas de changement, 
  //car un contrat est immuable et ne peut jamais etre modifié. 
  //Cette fonction pourra etre utilisée par l'owner, de l'extérieur (external) du contrat.
  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

//modifier pour éviter d'avoir à écrire sans arret la vérification du propriétaire du zombie
  modifier onlyOwnerOf(uint _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    _;
  }

  //ici je passe un pointeur sur une structure zombie.
  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Zombie storage _zombie) internal view returns (bool) {
      return (_zombie.readyTime <= now); //return true si 1 jour s'est écoulé depuis le dernier set du CoolDown
  }


  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal onlyOwnerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId]; //decla d'un zombie en storage, sur la blockchain
    require(_isReady(myZombie)); //il faut que cooldown soit passé
    _targetDna = _targetDna % dnaModulus; //verif 16 digits
    uint newDna = (myZombie.dna + _targetDna) / 2; //moyenne
    if (keccak256(abi.encode(_species)) == keccak256("kitty")) { //si meme hash, c'est que j'ai mangé un chat. ADN se termine par 99.
        newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); //je set ma variable avec la 10 var returned par getKitty.
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}