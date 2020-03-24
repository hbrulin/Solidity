pragma solidity ^0.4.19;

contract ZombieFactory {

    //event appelé tracké coté front.
    event NewZombie(uint zombieId, string name, uint dna);

    //variables d'état

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits; //pour s'assurer que dna de chaque zombie == 16 digits

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies; //tableau de structures, dynamique, public.

    mapping (uint => address) public zombieToOwner; //variable
    mapping (address => uint) ownerZombieCount; //variable, je peux verifier que l'uint mappé à l'addresse == 0 ou autre.

    //fin des variables d'état

    //les fonctions private ne sont pas accessibles par des classes héritées, contrairement aux fonctions internal.
    function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender; //msg sender renvoie adresse de celui qui appelle la ft coté front
        ownerZombieCount[msg.sender]++; //mapping comme une variable.
        NewZombie(id, _name, _dna); //déclenchement de l'event
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str)); //keccack256 : hache une string selon un hexa.
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0); //cette fonction ne peut être appelée que si l'adresse n'a aucun zombie créé. Que si l'uint mappé à l'adresse == 0.
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
