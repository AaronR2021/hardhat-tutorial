
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//create a library
library IterableMapping {


    struct Map{
    address[] keys;
    mapping(address=>uint) values;
    mapping(address=>uint) indexOf;
    mapping (address => bool) inserted;
    }

    function get(Map storage map, address key) public view returns(uint){
        return map.values[key];
    }

    function getKeyAtIndex(Map storage map,uint index) public view returns(address){
        return map.keys[index];
    }

    function size(Map storage map) public view returns(uint){
        return map.keys.length;
    }

    function set(Map storage map,address key, uint value) public {
        if(map.inserted[key]){
            map.values[key]=value;
        }else{
            map.keys.push(key);
            map.values[key]=value;
            map.indexOf[key]=map.keys.length;
            map.inserted[key]=true;
        }
    }


    function remove(Map storage map, address key) public {
        if(!map.inserted[key]){
            return;
        }else{
            
            delete map.inserted[key];
            delete map.values[key];


            uint index = map.indexOf[key]; //index of the array(keys) whos value you want to delete.
            address lastIndexValue = map.keys[map.keys.length-1];//last index value
            uint lastIndex = map.keys.length-1;//last index

            //update array(keys)
            map.keys[index]=lastIndexValue;
            map.keys.pop();

            //update IndexOf mapping
            map.indexOf[lastIndexValue]=index;//last address will get the previous keys index
            delete map.indexOf[key];
        }
    }

}

/*
* Mapping does not allow iteration over their keys or values. 
* You dont know the length of the map in advance. 
* To make it iterable, you need to know the keys in advance.
*/

contract TestIterableMap {
    using IterableMapping for IterableMapping.Map;
    //the above syntax means using the library(IterableMapping) on a specific datatype (IterableMapping.Map)

    IterableMapping.Map private map;
    //created a instance of the above datatype

    function test() public {
        map.set(address(0), 0);
        map.set(address(1), 100);
        map.set(address(2), 200); // insert
        map.set(address(2), 200); // update
        map.set(address(3), 300);

        map.remove(address(1));
        assert(map.size()==3);
        assert(map.getKeyAtIndex(2) == address(2));
        
    }


}