## Excercise 1

### Deploy CCIPTokenSender.sol using script (CCIPTokenSender.s.sol) on Avalanche Fuji : 0x852088495b0c291EF785aF131586c47186AeaD73
forge script ./script/CCIPTokenSender.s.sol:DeployCCIPTokenSender -vvvv --broadcast --rpc-url avalancheFuji

### Send 10LINK and 1CCIPBnM Tokens to the deployed contract : 0x852088495b0c291EF785aF131586c47186AeaD73
### Execute the whitelistChain(uint64) for Arbitrum Sepolia (chainselector: 3478487238524512106)
cast send 0x852088495b0c291EF785aF131586c47186AeaD73 --rpc-url avalancheFuji --private-key $PRIVATE_KEY 'whitelistChain(uint64)’ 3478487238524512106
### Execute the transferTokens(uint64,address,address,uint256) to send 1 CCIPBnM to arbitrumSepolia 
cast send 0x852088495b0c291EF785aF131586c47186AeaD73 --rpc-url avalancheFuji --private-key=$PRIVATE_KEY "transferTokens(uint64,address,address,uint256)" 3478487238524512106 0xE3085765a3C228768957B434fb309291CB5d31aa 0xD21341536c5cF5EB1bcb58f6723cE26e8D8E90e4 100000000000000000




## Excercise 2

### Deploy CCIPTokenAndDataSender.sol using script (CCIPTokenAndDataSender.s.sol) on Avalanche Fuji : 0xAb8FdD6FB437048856F6CbCa774533AFC059e00c
forge script ./script/CCIPTokenAndDataSender.s.sol:DeployCCIPTokenAndDataSender -vvvv --broadcast --rpc-url avalancheFuji
### Execute the whitelistChain(uint64) for Arbitrum Sepolia (chainselector: 3478487238524512106)
cast send 0xAb8FdD6FB437048856F6CbCa774533AFC059e00c --rpc-url avalancheFuji --private-key $PRIVATE_KEY 'whitelistChain(uint64)’ 3478487238524512106
### Send 10LINK and 1CCIPBnM Tokens to the deployed contract : 0xAb8FdD6FB437048856F6CbCa774533AFC059e00c
### Deploy CCIPTokenAndDataReceiver.sol using script (CCIPTokenAndDataReceiver.s.sol) on Arbitrum Sepolia : 0x2abc3C64aE06D0Ec3400030D94fE47cc86de7b35
forge script ./script/CCIPTokenAndDataReceiver.s.sol:DeployCCIPTokenAndDataReceiver -vvvv --broadcast --rpc-url arbitrumSepolia
### Execute the whitelistSourceChain(uint64) from CCIPTokenAndDataReceiver to accept message from Avalanche Fuji
cast send 0x2abc3C64aE06D0Ec3400030D94fE47cc86de7b35 --rpc-url arbitrumSepolia --private-key $PRIVATE_KEY 'whitelistSourceChain(uint64)'  14767482510784806043
### Execute the whitelistSender(uint64) from CCIPTokenAndDataReceiver to accept message from the CCIPTokenAndDataSender.sol deployed on avalanche Fuji
cast send 0x2abc3C64aE06D0Ec3400030D94fE47cc86de7b35 --rpc-url arbitrumSepolia --private-key $PRIVATE_KEY ‘whitelistSender(address)' 0xAb8FdD6FB437048856F6CbCa774533AFC059e00c
### Execute the transferTokens(uint64,address,address,uint256) to send 1 CCIPBnM to arbitrumSepolia 
cast send 0xAb8FdD6FB437048856F6CbCa774533AFC059e00c --rpc-url avalancheFuji --private-key=$PRIVATE_KEY "transferTokens(uint64,address,address,uint256)" 3478487238524512106 0x2abc3C64aE06D0Ec3400030D94fE47cc86de7b35 0xD21341536c5cF5EB1bcb58f6723cE26e8D8E90e4 1000000000000000000



## Excercise 3 - Not Foundry, but Hardhat

### Via npc env-enc set password and environment variables
### Deploy TicTacToe Contract on Avalanche Fuji: 0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f
### Deploy TicTacToe Contract on Arbitrum Sepolia: 0x495de6E1AfAe90aD2F31824Bda7BEF1AA619A3f0
### Update the router for the TicTacToe Contract on Avalanche Fuji: 0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f with 0xF694E193200268f9a4868e4Aa017A0118C9a8177
npx hardhat ttt-update-router --blockchain avalancheFuji --contract 0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f --router 0xF694E193200268f9a4868e4Aa017A0118C9a8177
### Update the router for the TicTacToe Contract on Arbitrum Sepolia: 0x495de6E1AfAe90aD2F31824Bda7BEF1AA619A3f0 with 0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165
npx hardhat ttt-update-router --blockchain arbitrumSepolia --contract 0x495de6E1AfAe90aD2F31824Bda7BEF1AA619A3f0 --router 0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165
### Player 1 starts the game
npx hardhat ttt-start --source-blockchain avalancheFuji --sender  0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f --destination-blockchain arbitrumSepolia --receiver 0x495de6E1AfAe90aD2F31824Bda7BEF1AA619A3f0
### Check the sessionID: 0x8c24ecabe95d70abf050f372403dd6c63a60b0666160a4fe92c0cd5e969d49a9
npx hardhat ttt-get-sessionId --blockchain avalancheFuji --contract 0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f  --index 0

### Player 1 makes a move on Avalanche Fuji: 0,0
npx hardhat ttt-move --x 0 --y 0 --player 1 --session-id 0x8c24ecabe95d70abf050f372403dd6c63a60b0666160a4fe92c0cd5e969d49a9 --source-blockchain avalancheFuji --sender 0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f --destination-blockchain arbitrumSepolia --receiver 0x495de6E1AfAe90aD2F31824Bda7BEF1AA619A3f0

### Player 2 makes a move on Arbitrum Sepolia 1,0
npx hardhat ttt-move --x 1 --y 0 --player 2 --session-id 0x8c24ecabe95d70abf050f372403dd6c63a60b0666160a4fe92c0cd5e969d49a9 --source-blockchain arbitrumSepolia --sender 0x495de6E1AfAe90aD2F31824Bda7BEF1AA619A3f0 --destination-blockchain avalancheFuji --receiver 0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f

### Player 1 makes a move on Avalanche Fuji 0,1
npx hardhat ttt-move --x 0 --y 0 --player 1 --session-id 0x8c24ecabe95d70abf050f372403dd6c63a60b0666160a4fe92c0cd5e969d49a9 --source-blockchain avalancheFuji --sender 0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f --destination-blockchain arbitrumSepolia --receiver 0x495de6E1AfAe90aD2F31824Bda7BEF1AA619A3f0

### Player 2 makes a move on Arbitrum Sepolia 1,1
npx hardhat ttt-move --x 1 --y 0 --player 2 --session-id 0x8c24ecabe95d70abf050f372403dd6c63a60b0666160a4fe92c0cd5e969d49a9 --source-blockchain arbitrumSepolia --sender 0x495de6E1AfAe90aD2F31824Bda7BEF1AA619A3f0 --destination-blockchain avalancheFuji --receiver 0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f

### Player 1 makes a move on Avalanche Fuji 0,3
npx hardhat ttt-move --x 0 --y 0 --player 1 --session-id 0x8c24ecabe95d70abf050f372403dd6c63a60b0666160a4fe92c0cd5e969d49a9 --source-blockchain avalancheFuji --sender 0xE031ddec5d0De5Ceb4BA8E0993bbf1C4789B4d5f --destination-blockchain arbitrumSepolia --receiver 0x495de6E1AfAe90aD2F31824Bda7BEF1AA619A3f0

