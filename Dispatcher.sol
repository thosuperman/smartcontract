/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract Dispatcher at 0xf876c67ce21a03a848dbae562d583296ee5a8449
*/
pragma solidity ^0.4.15;


contract Dispatcher {
    address target;

    function Dispatcher(address _target) public {
        target = _target;
    }

    function() public {
        assembly {
            let _target := sload(0)
            calldatacopy(0x0, 0x0, calldatasize)
            let retval := delegatecall(gas, _target, 0x0, calldatasize, 0x0, 0)
            let returnsize := returndatasize
            returndatacopy(0x0, 0x0, returnsize)
            switch retval case 0 {revert(0, 0)} default {return (0, returnsize)}
        }
    }
}