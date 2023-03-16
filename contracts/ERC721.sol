
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//basically to tell other contracts what interfaces it supports
interface IERC165 {
    function supportsInterface(bytes4 interfaceID) 
    external view returns (bool);
}

interface IERC721 is IERC165 {
    //it inherits the IERC165 interface

    //! returns how many NFT's owner has
    function balanceOf(address owner) external view returns (uint balance);

    //! Whos the owner of this tokenId
    function ownerOf(uint tokenId) external view returns (address owner);

    //! safeTransferFrom() includes an additional check to ensure that the recipient is capable of receiving ERC721 tokens before the transfer is completed.
    //! It allows the transfer of a specific token from the message sender's account to a recipient account.
    function safeTransferFrom(address from, address to, uint tokenId) external;

    //! this is the same as above, except an optional calldata field
    //! calldata reppresents input data of a function call. 
    //! since its read only, its advisible to use it on the parameters that rercieve values from other contracts as it saves on gas
    function safeTransferFrom(
        address from,
        address to,
        uint tokenId,
        bytes calldata data
    ) external;

    //! similar to above, but no checks here
    function transferFrom(address from, address to, uint tokenId) external;

    //! msg.sender approves "to" to transfer that NFT on its behalf.
    function approve(address to, uint tokenId) external;

    //! checks which 3rd party has the permission to transfer this token
    function getApproved(uint tokenId) external view returns (address operator);

    //! sets approval/rejection based on boolean value for address(operator)
    //! operator can transact on behalf of msg.sender
    function setApprovalForAll(address operator, bool _approved) external;

    //! function only checks if the operator has been granted approval to transfer all of the owner's NFTs.
    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns (bool);
}

interface IERC721Receiver {
    //!This function is used to recieve and handle incoming ERC-721 token transfer
    function onERC721Received(
        address operator,//* address of the account transfering the token(3rd party)
        address from, //* original owner of the token
        uint tokenId,//* TokenId of the NFT
        bytes calldata data //*additiona data to send with transaaction
    ) external returns (bytes4);
    /*
    ! Explain the above function in detail
    * When a ERC721 token is transfered from A to B, 
    * The (ERC721)-contract will call the function "onERC721Received" from the recieving contract (B), and pass some info along with it
    * Contract (B) uses this info to decide to accept the token or no.
    * If it decides to accept, it should return a byte value of (0x150b7a02), 
    * anything else returned is considered unsuccessful.    

     */
}

contract ERC721 is IERC721 {
    //here you inherit all the interface methods
    event Transfer(address indexed from, address indexed to, uint indexed id);
    event Approval(address indexed owner, address indexed spender, uint indexed id);
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    // Mapping from token ID to owner address
    //! uint A is owned by address(0x1234...)
    mapping(uint => address) internal _ownerOf;

    // Mapping owner address to token count
    //! address(A) owns X tokens
    mapping(address => uint) internal _balanceOf;

    // Mapping from token ID to approved address
    //! This token X can be traded of by address(Y)
    mapping(uint => address) internal _approvals;

    // Mapping from owner to operator approvals
    //! Aaron given Harshitha permission to transact with all his tokens.
    mapping(address => mapping(address => bool)) public isApprovedForAll;

    //! IERC165's method that was inherited by IERC721
    function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        //interfaceIds are fixed for different tokens
        return
            interfaceId == type(IERC721).interfaceId || //means it accepts erc721 tokens, so you can use the standards methods mentioned to interact
            interfaceId == type(IERC165).interfaceId;
    }

    function ownerOf(uint id) external view returns (address owner) {
        owner = _ownerOf[id];
        require(owner != address(0), "token doesn't exist");
    }

    function balanceOf(address owner) external view returns (uint) {
        require(owner != address(0), "owner = zero address");
        return _balanceOf[owner];
    }

    function setApprovalForAll(address operator, bool approved) external {
        isApprovedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function approve(address spender, uint id) external {
        address owner = _ownerOf[id];
        require(
            msg.sender == owner || isApprovedForAll[owner][msg.sender],
            "not authorized"
        );

        _approvals[id] = spender;

        emit Approval(owner, spender, id);
    }

    function getApproved(uint id) external view returns (address) {
        require(_ownerOf[id] != address(0), "token doesn't exist");
        return _approvals[id];
    }

    function _isApprovedOrOwner(
        address owner,
        address spender,
        uint id
    ) internal view returns (bool) {
        return (spender == owner ||
            isApprovedForAll[owner][spender] ||
            spender == _approvals[id]);
    }

    function transferFrom(address from, address to, uint id) public {
        require(from == _ownerOf[id], "from != owner");
        require(to != address(0), "transfer to zero address");

        require(_isApprovedOrOwner(from, msg.sender, id), "not authorized");

        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[id] = to;

        delete _approvals[id];

        emit Transfer(from, to, id);
    }

    function safeTransferFrom(address from, address to, uint id) external {
        transferFrom(from, to, id);

        require(
            to.code.length == 0 ||
                IERC721Receiver(to).onERC721Received(msg.sender, from, id, "") ==
                IERC721Receiver.onERC721Received.selector,
            "unsafe recipient"
        );
    }

    function safeTransferFrom(
        address from,
        address to,
        uint id,
        bytes calldata data
    ) external {
        transferFrom(from, to, id);

        require(
            to.code.length == 0 ||
                IERC721Receiver(to).onERC721Received(msg.sender, from, id, data) ==
                IERC721Receiver.onERC721Received.selector,
            "unsafe recipient"
        );
    }

    function _mint(address to, uint id) internal {
        require(to != address(0), "mint to zero address");
        require(_ownerOf[id] == address(0), "already minted");

        _balanceOf[to]++;
        _ownerOf[id] = to;

        emit Transfer(address(0), to, id);
    }

    function _burn(uint id) internal {
        address owner = _ownerOf[id];
        require(owner != address(0), "not minted");

        _balanceOf[owner] -= 1;

        delete _ownerOf[id];
        delete _approvals[id]; //*if theres nothing, it just ignores

        emit Transfer(owner, address(0), id);
    }
}

contract MyNFT is ERC721 {
    function mint(address to, uint id) external {
        _mint(to, id);
    }

    function burn(uint id) external {
        require(msg.sender == _ownerOf[id], "not owner");
        _burn(id);
    }
}

//* What is IERC165?
/*

Let's say the contract that manages the assets was developed by Alice,
and the contract that allows buying and selling was developed by Bob. Alice and Bob may 
have developed their contracts independently, and they may have used different methods and 
interfaces to achieve their goals.

This can make it difficult for Alice and Bob's contracts to communicate with each other, 
because they may not have a standardized way of exchanging information. 
For example, Alice's contract might expect a certain format of input data that Bob's contract 
doesn't provide, or Bob's contract might return output data in a different format than 
Alice's contract expects.

This is where the IERC165 interface comes in. If Alice's and Bob's contracts both implement 
this interface, they can signal to each other which interfaces or capabilities they support. 
This makes it easier for them to interact with each other in a standardized way,
without having to worry about the specific methods or interfaces that each contract provides.
For example, let's say Alice's contract implements the ERC721 standard for 
non-fungible tokens (NFTs), and Bob's contract implements the ERC20 standard for fungible tokens. 
Both of these standards are widely used and have a set of standardized methods and 
interfaces for managing tokens.

If Alice's and Bob's contracts implement the IERC165 interface and provide implementations 
for the supportsInterface function, they can signal to each other which standards they support. 
This makes it easier for them to exchange tokens, because they can rely on a standardized set of 
methods and interfaces.

*/

//* What do i mean by "by implementing IERC165 interface, contracts can signal other contracts  
//which interface or capabilities they support?"
/**
When we say "which interfaces or capabilities they support" in the context of the 
IERC165 interface, we are referring to the different standards, interfaces, 
and functionalities that a smart contract can provide.

For example, a contract may implement the ERC20 standard for managing fungible tokens, 
or the ERC721 standard for managing non-fungible tokens. 
By implementing these standards, the contract is providing a specific set of methods and interfaces 
that external applications can use to interact with the contract.
 */

//* does it mean it makes the interface of ERC721 that the contract interact visible to other contracts?
/*

Yes, that's correct! By implementing the IERC165 interface and checking for the IERC721 interface ID 
in the supportsInterface function, the smart contract is essentially signaling to other contracts 
and external applications that it implements the ERC721 standard for managing non-fungible tokens.

This means that other contracts and applications can interact with the contract using 
the standardized ERC721 methods and interfaces, which makes it easier for them to integrate 
with the contract and perform operations like transferring and managing non-fungible tokens.

Without implementing the IERC165 interface and signaling which interfaces and capabilities 
the contract supports, other contracts and applications would have to manually check which methods 
and interfaces the contract provides, which would make integration and interoperability much more 
difficult.

*/

//! IN SHORT: other contracts can ask you if you follow the ERC721/ERC20 standard, if your answer is yes. 
//! they can go ahead and use appropreate methods as they know the contract follows the respective standard

//* ERC721 is an NFT
