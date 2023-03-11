// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract MerkelTreeCreate {
    bytes32[] public hashes;

    constructor() {
        string[4] memory transactions = [
            "alice -> bob",
            "bob -> dave",
            "carol -> alice",
            "dave -> bob"
        ];

        for (uint i = 0; i < transactions.length; i++) {
            hashes.push(keccak256(abi.encodePacked(transactions[i])));
        }
        uint n = transactions.length;//4
        uint offset = 0;
        while(n>0){

            for(uint i = 0; i<n-1;i+=2){
                hashes.push(
                    keccak256(abi.encodePacked(hashes[i+offset],hashes[i+1+offset]))
                );
            }
            offset+=n;
            n/=2;

        }
        
    }//constructor ends here
    function getRoot() public view returns (bytes32){
        return hashes[hashes.length-1];
    }
}