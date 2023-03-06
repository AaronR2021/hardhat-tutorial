// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract IfElse {
    function foo(uint8 x) public pure returns(uint8) {
        if(x<10){
            return 0;
        }
        else if(x>=10&&x<=20){
            return 1;
        }
        else{
            return 2;
        }
    }
    function ternary(uint8 _x) public pure returns(uint8){
        return _x>=10?1:0;
    }


}