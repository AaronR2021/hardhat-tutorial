//* SENDING ETHER
/*
* The transfer- used to transfer ether from the contract to an address. It has gas limit of 2300wei.
It will throw an exception if the reciepient is a contract or if fallback function fails
!   address payable recipient = 0x1234567890123456789012345678901234567890;
!   recipient.transfer(1 ether);
*/

/*
* The send function is similar to the transfer, but here you can set the gas limit, and it also returns a boolean. 
* we usually use the require(condition,"fallback message") along with the send function. 
! address payable recipient = 0x1234567890123456789012345678901234567890;
! bool success = recipient.send(1 ether);
! require(success, "Failed to send Ether");
*/

/*
* The call function is the most flexible to trnsfer Ether, here you can set gas value and get any return data once the call is executed. 
address payable recipient = 0x1234567890123456789012345678901234567890;
bool success;
bytes memory returnData;
(success, returnedFunctionalData) = recipient.call{value: 1 ether, gas: 100000}("dataIfAny");
if (!success) {
    ! handle transaction failure
}
*/
//!_____________________________________________________________________________
//* Recieving ETHER
// receive() is called if msg.data is empty, otherwise fallback() is called.
/*

*/