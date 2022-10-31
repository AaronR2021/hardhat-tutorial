// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

contract Loop {
    function loop() pure public {
        // for loop
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                // Skip to next iteration with continue
                continue;
            }
            if (i == 5) {
                // Exit loop with break
                break;
            }
        }

        // while loop
        uint j; //by default set to 0
        while (j < 10) {
            j++;
        }
    }
}

/*
! SideNote:
*   solidity supports for,while, and do while loops.
*   careful with your loops, if entered infinite loop, you'll loose your gas for no reason
*   Gas, is a unit of computation on the Ethereum Network.
*   The cost of gas spent depends on your transaction, as every write to a blockchain costs gas.
?   The amount you end up spending(gas fees) = gas spent * (base fees + priority fees).
*   Gas Spent is the total amount of gas (in gas units) that were used to execute the transaction.
*   Base fees depends on the traffic on the network trying to add their transaction to the block.
?   greater than 15M > Higher Base fees.
?   _lesser than 15M  < Lower Base fees.
?   priority fees are like a bribe to the miner to give your transaction a higher priority.
*/