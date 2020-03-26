pragma solidity ^0.4.19;

import "./ownable.sol";

//le contrats et ses héritiers hérient de Ownable, pourront appeler le modificateur de ft onlyOwner
contract ZombieFactory is Ownable {

    //event appelé tracké coté front.
    event NewZombie(uint zombieId, string name, uint dna);

    //variables d'état

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits; //pour s'assurer que dna de chaque zombie == 16 digits
    uint cooldownTime = 1 days; //days, comme seconds, minutes, hours, now - unités de temps solidity, en secondes.

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        //regroupement des uints 32 pour que solidity les emboite dans la struct - moins de place, economie de gas.
    }

    Zombie[] public zombies; //tableau de structures, dynamique, public.

    mapping (uint => address) public zombieToOwner; //variable
    mapping (address => uint) ownerZombieCount; //variable, je peux verifier que l'uint mappé à l'addresse == 0 ou autre.

    //fin des variables d'état

    //les fonctions private ne sont pas accessibles par des classes héritées, contrairement aux fonctions internal.
    function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1; // 1 pour level, unix seconds + 1 day in seconds pour readyTime. Je cast en uint32 car now renvoie uint256 par defaut.
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
