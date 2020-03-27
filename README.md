# Solidity

We can define programmatically the rules of a business contract, in a simple machine language, to bring people together and allow them to conduct business in a trustable, secure, and automated fashion.

EVM : Ethereum Virtual Machine (EVM) allows Ethereum nodes to store and process data in exchange for payment.

Solidity Language is a tool that we use to generate machine-level code that can execute on the EVM, it’s a language with a compiler, which generates EVM machine-level bytecode to be run on the Ethereum nodes, for payment.

We are working within a stack-and-memory model with a 32-byte instruction word size, the EVM gives us access to the program “stack” which is like a register space where we can also stick memory addresses to make the Program Counter loop/jump (for sequential program control), an expandable temporary “memory” and a more permanent “storage” which is actually written into the permanent blockchain, and most importantly, the EVM requires total determinism within the smart contracts.


There are two types of accounts in Ethereum: external accounts (managed by public-private key pairs) and contract accounts (controlled by the code stored together with the account).

Nonce : valeur de circonstance.
Miners take transaction fees : POS.

Blocks are data that enters the chain in intervals. Each block has to be verified (consensus) and time stamped.

Decentralized applications : Dapps.

How does Ethereum work? Basically, it executes tasks using special instructions. These are called opcodes. Every opcode is 1 byte in size and encoded to bytecode. It gets split into its bytes when you execute a specific task.

Tout est encapsulé dans un contrat : fonctions et variables.

Variables : 
Les variables d'état sont stockées de manière permanente dans le stockage du contrat. Cela signifie qu'elles sont écrites dans la blockchain Ethereum. C'est comme écrire dans une base de données.
les variables d'état (déclarées en dehors des fonctions) sont par défaut storage et écrites de manière permanente dans la blockchain, alors que les variables déclarées à l'intérieur des fonctions sont memory et disparaissent quand l'appel à la fonction est terminé.
Si néanmoins au sein d'une ft je déclare une variable et que je veux qu'elle soit sur la blockchain, je peux la déclarer storage. elle sera alors un pointeur vers une adresse sur la blockchain. En revanche, si je la déclare memory, j'aurais dans ma ft une simple copie de la variable qui se trouve à l'adresse sur la blockchain. 

Tableaux : dynamiques ou non. Si on déclare un tableau public, Solidity créera automatiquement une méthode d'accès. Les autres contrats vont puvoir lire mais pas écrire dans le tableau.

Ressources :
- Ethereum Design Rationale : https://github.com/ethereum/wiki/wiki/Design-Rationale
- Solidity tuto : https://blockgeeks.com/guides/solidity/
- Ethereum Mining and POW/POS: https://blockgeeks.com/guides/ethereum-mining-proof-stake/
- Truffle : https://github.com/trufflesuite/truffle
- Official doc and tuto : https://solidity.readthedocs.io/en/v0.6.4/ 
- BitDegree Tuto : https://www.bitdegree.org/learn/solidity-tutorial
- Remix : https://remix.ethereum.org/#optimize=false&evmVersion=null&version=soljson-v0.6.1+commit.e6f7d5a4.js 
- EVM and memory: https://www.bitdegree.org/learn/ethereum-virtual-machine 
- Blockchain basics : https://www.bitdegree.org/learn/solidity-blockchain 
- Intro smart contracts : https://www.bitdegree.org/learn/solidity-smart-contracts 
- Crypto Zombie : https://cryptozombies.io/fr/ 
- Hack Smart Contracts : https://ethernaut.openzeppelin.com/ 

Un _ évènement _ est un moyen pour votre contrat d'indiquer à votre application frontale (front-end) que quelque chose vient d'arriver sur la blockchain, l'application frontale pouvant être «à l'écoute» de certains événements pour prendre des mesures quand ils se produisent.


The address of an external account is determined from the public key while the address of a contract is determined at the time the contract is created (it is derived from the creator address and the number of transactions sent from that address, the so-called “nonce”).

#installer web3.js
npm install web3.
npm est le gestionnaire de paquets officiel de Node.js.


To read :
- https://github.com/ConsenSys/smart-contract-best-practices
- https://github.com/OpenZeppelin/openzeppelin-contracts
- https://blog.ethereum.org/2016/06/19/thinking-smart-contract-security/
- https://blog.ethereum.org/2016/06/10/smart-contract-security/
- https://eattheblocks.com/best-way-to-learn-solidity-for-beginners/