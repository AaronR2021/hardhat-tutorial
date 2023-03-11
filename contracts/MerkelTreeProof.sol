//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MerkleProof {
    function verify(bytes32[] memory proof,bytes32 root,bytes32 leaf,uint index) public pure returns(bool){
        bytes32 hash = leaf;
        for (uint i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if(index%2==0){
                hash=keccak256(abi.encodePacked(hash,proofElement));
            }
            else{
                hash=keccak256(abi.encodePacked(proofElement,hash));

            }

            index=index/2;//as you go up the merkle tree the no. of elements reduce by half
        }

        return hash==root;
    }
}
/* 
!SideNote=>
* The lenght of a merkle is 2^n; if not we add the last element(hash) as padding to fill it up.
* A merkleTree is used to show that a transaction is present in a block. 
* Merkle root is saved in the block. 
* With the poof,root,leafToFind,index if we can contstruct the same root, the element is present.
? We Start with the leaf (byte32 hash=leaf)
? recompute the merkle root
* hash updates using the elements of the proof
! Very Important=>
? What is a proof array?
* A Proof array holds the hashes of the siblings alng the path from leaf to Root Node.
If there are 4 leaves with values a, b, c, and d, and we want to prove the inclusion of leaf "a" in the Merkle tree, 
then the proof array would contain the values of the nodes on the path from leaf "a" to the Merkle root.
To construct the proof, we start by hashing the adjacent pairs of leaves (a+b and c+d) to get the two intermediate nodes at the next level of the tree.
Then, we hash the two intermediate nodes together (hash(a+b) + hash(c+d)) to get the Merkle root.
To prove that leaf "a" is included in the Merkle tree,
we need to provide the values of the nodes on the path from leaf "a" to the Merkle root.
In this case, the proof array would contain the values of nodes b, hash(c+d), 
and the Merkle root (hash(a+b) + hash(c+d)).
So the proof array would be [b, hash(c+d), Merkle root].
* If our index is 2k or 2k+1, our parent index is k (index=index/2) > since we are doing uint division> 0.5~0
*/