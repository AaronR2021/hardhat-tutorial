// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//BASE X
contract X{
    string public str;
    constructor(string memory _x){
        str=_x;
    }
}

//BASE Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

//BASE Z, which inherits X and Y, we use *is* to inherit
contract Z is X("Hello X"), Y("Hello Y"){

    // order in which the constructor is called is X->Y->Z
}