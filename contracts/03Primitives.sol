// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Primitives {
    //bool holds true or false values
    bool public boo=true;
    //uint holds only positive numbers
    uint8 public max_u8 = 255;
    uint16 public max_u16 = 65535;
    uint32 public max_u32 = 4294967295;
    uint64 public max_u64 = 18446744073709551615;
    uint128 public max_u128 =  340282366920938463463374607431768211455;
    uint256 public max_u256;

    //int holds both negitive and positive numbers

    //int256 ranges from -2 ** 255 to 2 ** 255 - 1
    //int128 ranges from -2 ** 127 to 2 ** 127 - 1
    int8 public in8 = -128;
    int8 public ip8 = 127;
    int16 public in16 = -32768;
    int16 public ip16 = 32767;

    //address datatype holds address in a given variable
    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

}

/*
Primitives
- bool
- uint
- int
- address
 */