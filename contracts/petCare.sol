pragma solidity ^0.4.24;

contract petCare {
    /*
    @title PetCare
    @author seshanthS
    @description Contract to help animals. People can donate ether. The donated ether can only be spent after
    the donater approved. The donater have to verify the case befpre approving.
    */
    struct Case {
        uint amount;
        uint caseId;
        address reporter;
        //mapping (address => uint) donaters;
        
    }
    
    mapping (uint => Case) public caseMap;
    mapping (uint => address) users;
    
    /* @param address of donater
        @param caseId
        @param amount
        @dev Shows the amount donated by every person for a different cases.
    */
    mapping (address => mapping(uint => uint)) public donatedTocaseAmount;
    
    /*@param caseId
      @param amount
      @param address of receiver(ex. Vet, Hospital)
      @dev Total amount allowed to withdraw for a specific case
    */
    mapping (uint => mapping(address => uint)) amountAllowed;
  
    uint id = 0;
    uint userId = 0;
    
    modifier verifiedUsers(uint _userId) {
        require(users[_userId] == msg.sender);
        _;
    }
    
    /*  @dev Register the user.
    */
    function registerUser() public returns (uint){
      //userId = uint8(uint256(keccak256(block.timestamp, block.difficulty)));
      
      //@dev Verify whether the user's address is already registerd.'
        for (uint i = 0; i <= userId; i++){
            require(users[i] != msg.sender);
            }
        users[userId] = msg.sender;
        userId++;
        return userId - 1;
        
    }
    
    function addCase(uint _userId) public verifiedUsers(_userId) returns(uint){
        caseMap[id].amount = 0;
        caseMap[id].caseId = id;
        caseMap[id].reporter = msg.sender;
        id++;
        return id - 1;
    }
    
    function donate(uint _userId, uint _caseId) external verifiedUsers(_userId) payable {
        //caseMap[_caseId].donaters[msg.sender] += msg.value;
        donatedTocaseAmount[msg.sender][_caseId] += msg.value;
        caseMap[_caseId].amount += msg.value;
    }
    
    function authorize(uint _caseId, uint amount, address _to) public {
        require(amount <= donatedTocaseAmount[msg.sender][_caseId]);
        amountAllowed[_caseId][_to] += amount;
        
    }
    
    /* @param _caseId id of the caseMap
        @param _amount amount to send in wei
        @dev Called by the receiver(i.e doctor,hospital). Here msg.sender is the doctor, hospital etc  
    */
    function withdraw(uint _caseId, uint _amount) public {
        require(_amount <= amountAllowed[_caseId][msg.sender]);
        msg.sender.transfer(_amount);
         
    }
    
    function contractBalance() public view returns (uint){
        return this.balance;
    }
}