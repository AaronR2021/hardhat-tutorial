// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Todos {

    //create a struct
    struct Todo{
        string text;
        bool isComplete;
    }

    // An array of 'Todo' struct
    Todo[] public todos;

    function addTodo(string calldata _text, bool _bool) public {
        //calldata ~ to memory but, read only. cannot modify data
        todos.push(Todo({text:_text,isComplete:_bool}));
    }

    function retrieveIndex(uint index) public view returns(string memory,bool){
        Todo storage todo=todos[index];
        return (todo.text,todo.isComplete);
    }

    //what ever you update on todo will be updated on the blockchain automatically because of storage
    function update(string memory _text,bool _isComplete,uint index) public {
        Todo storage todo = todos[index];
        //what ever you update on todo will be updated on the blockchain automatically because of storage
        todo.text=_text;
        todo.isComplete=_isComplete;
    }


}