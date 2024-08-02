pragma solidity ^0.4.18;

contract HelloWorld{
    string private Text = "Hello World";

    function ChangeText(string _text) public{
        Text = _text;
    }

    function GetHelloWorld() public view returns (string){
        return Text;
    }
}