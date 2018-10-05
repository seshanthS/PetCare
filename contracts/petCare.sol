pragma solidity ^0.4.25;

contract petCare {
    
    struct Case {
        uint amount;
        uint caseId;
        address reporter;
        //mapping (address => uint) donaters;
        
    }
    
    mapping (uint => Case)public caseMap;
    mapping (uint => address) users;
    mapping (address => mapping(uint => uint)) public donatedTocaseAmount;
    
    uint id = 0;
    uint userId =0;
    
    modifier verifiedUsers(uint _userId) {
        require(users[_userId] == msg.sender);
        _;
    }
    
    function registerUser() public {
        for (uint i = 0; i <= userId; i++){
            require(users[i] != msg.sender);
           /* if (users[i] == msg.sender){
                revert();
            */
            }
        users[userId] = msg.sender;
        userId++;
    }
    
    function addCase(uint _userId) public verifiedUsers(_userId) {
        caseMap[id].amount = 0;
        caseMap[id].caseId = id;
        caseMap[id].reporter = msg.sender;
        id++;
    }
    
    function donate(uint _userId, uint _caseId) public verifiedUsers(_userId) payable {
        //caseMap[_caseId].donaters[msg.sender] += msg.value;
        donatedTocaseAmount[msg.sender][_caseId] += msg.value;
    }
    
    function contractBalance() public view returns (uint){
        return this.balance;
    }
}
