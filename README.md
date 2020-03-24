# Solidity

We can define programmatically the rules of a business contract, in a simple machine language, to bring people together and allow them to conduct business in a trustable, secure, and automated fashion.

EVM : Ethereum Virtual Machine (EVM) allows Ethereum nodes to store and process data in exchange for payment.

Solidity Language is a tool that we use to generate machine-level code that can execute on the EVM, it’s a language with a compiler, which generates EVM machine-level bytecode to be run on the Ethereum nodes, for payment.

We are working within a stack-and-memory model with a 32-byte instruction word size, the EVM gives us access to the program “stack” which is like a register space where we can also stick memory addresses to make the Program Counter loop/jump (for sequential program control), an expandable temporary “memory” and a more permanent “storage” which is actually written into the permanent blockchain, and most importantly, the EVM requires total determinism within the smart contracts.



Nonce : valeur de circonstance.
Miners take transaction fees : POS.

Ressources :
- Ethereum Design Rationale : https://github.com/ethereum/wiki/wiki/Design-Rationale
- Solidity tuto : https://blockgeeks.com/guides/solidity/
- Ethereum Mining and POW/POS: https://blockgeeks.com/guides/ethereum-mining-proof-stake/
