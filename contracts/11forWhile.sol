// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Loop {
    function loop() public {
    for(uint i=0; i<10; i++){
        if(i==3){
            continue;
        }
        if(i==8){
            break;
        }
    }
    }
}
/*
- careful while using while or do while loop as you might end up spending gas upto its limit.
*/