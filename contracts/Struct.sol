
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Todos {
    //!Declaring a structure 
    struct Todo {
        string text;
        bool completed;
    }

    // An array of 'Todo' structs
    Todo[] public todos;

    function create(string calldata _text) public {
        // 3 ways to initialize a struct
        // - calling it like a function
        //? method -1
        todos.push(Todo(_text, false)); //* parameters follow the order.

        // key value mapping
        //? method -2
        todos.push(Todo({text: _text, completed: false}));//* pass it like an object.

        // initialize an empty struct and then update it
        Todo memory todo;
        todo.text = _text;
        // todo.completed initialized to false, as bools defaults value is false.
        todos.push(todo);
    }

    // Solidity automatically created a getter for 'todos' so
    // you don't actually need this function.
    function get(uint _index) public view returns (string memory text, bool completed) {
        Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // update text
    function updateText(uint _index, string calldata _text) public { //!in calldata you cannot change the data, so its gas efficient.
        Todo storage todo = todos[_index]; //storage means with respect to the blockchain, so changes are done in the blockchain.
        todo.text = _text;
    }

    // update completed
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}

//! Structs are used to group related data
//* similar to an object, but here all related data have their own datatype.
//* A structures values are passed as arguments.
