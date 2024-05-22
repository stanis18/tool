// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/// @notice  invariant  totalSupply  ==  __verifier_sum_uint(users[addr])
contract ERC20EvolSpec {

  address public owner;
  address public config;
  bool public locked;
  address public dao;
  address public badgeLedger;
  uint256 public totalSupply;

  mapping (address => uint256) balances;
  mapping (address => mapping (address => uint256)) allowed;
  mapping (address => bool) seller;

  /// @notice postcondition users[_owner] == balance
  function balanceOf(address _owner) public returns (uint256 balance);
  
  /// @notice  postcondition ( ( users[msg.sender] ==  __verifier_old_uint (users[msg.sender] ) - _value  && msg.sender  != _to ) ||   ( users[msg.sender] ==  __verifier_old_uint ( users[msg.sender] ) && msg.sender  == _to ) &&  success ) || !success
  /// @notice  postcondition ( ( users[_to] ==  __verifier_old_uint ( users[_to] ) + _value  && msg.sender  != _to ) ||   ( users[_to] ==  __verifier_old_uint ( users[_to] ) && msg.sender  == _to ) &&  success ) || !success
  /// @notice  emits  Transfer 
  function transfer(address _to, uint256 _value) public returns (bool success);
 
  /// @notice  postcondition ( ( users[_from] ==  __verifier_old_uint (users[_from] ) - _value  &&  _from  != _to ) || ( users[_from] ==  __verifier_old_uint ( users[_from] ) &&  _from == _to ) &&  success ) || !success
  /// @notice  postcondition ( ( users[_to] ==  __verifier_old_uint ( users[_to] ) + _value  &&  _from  != _to ) || ( users[_to] ==  __verifier_old_uint ( users[_to] ) &&  _from  == _to ) &&  success ) || !success
  /// @notice  postcondition ( allowed[_from ][msg.sender] ==  __verifier_old_uint (allowed[_from ][msg.sender] ) - _value ) || ( allowed[_from ][msg.sender] ==  __verifier_old_uint (allowed[_from ][msg.sender] ) && !success) ||  _from  == msg.sender
  /// @notice  postcondition  allowed[_from ][msg.sender]  <= __verifier_old_uint (allowed[_from ][msg.sender] ) ||  _from  == msg.sender
  /// @notice  emits  Transfer 
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
  
  /// @notice  postcondition (allowed[msg.sender ][ _spender] ==  _value  &&  success) || ( allowed[msg.sender ][ _spender] ==  __verifier_old_uint ( allowed[msg.sender ][ _spender] ) && !success )    
  /// @notice  emits  Approval
  function approve(address _spender, uint256 _value) public returns (bool success);

  /// @notice postcondition allowed[_owner][_spender] == remaining
  function allowance(address _owner, address _spender) public returns (uint256 remaining);
 
  function mint(address _owner, uint256 _amount) public returns (bool success);
 
  function mintBadge(address _owner, uint256 _amount) public returns (bool success);

  function registerDao(address _dao) public returns (bool success);
  
  function registerSeller(address _tokensales) public returns (bool success);

  event Transfer(address indexed _from, address indexed _to, uint256 indexed _value);
  event Mint(address indexed _recipient, uint256 indexed _amount);
  event Approval(address indexed _owner, address indexed _spender, uint256 indexed _value);
}






