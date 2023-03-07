// SPDX-License-Identifier: MIT
contract FunctionModifiers {
    /*
      Function Modifiers are a block of code that runs before/after a function call.
    */
   address public owner;
   bool locked;
   constructor(){
    owner=msg.sender;
   }
   
   modifier onlyOwner(){
    require(msg.sender == owner, "Not owner");
    _;
   }

   modifier validAddress(address _address){
    //address(0) represents 0x0000000000000000000000000000000000000000.
    require(_address!=address(0),'Not a valid address');
    _;
   }

   modifier lockDuringExecution(){
    locked=true;
    _;
    locked=false;
   }

   function adminFunction() public onlyOwner validAddress(owner)  {
    //if you pass in parameter, then you pass in parameter else just function name is enough. 
    locked=true;
   }
}