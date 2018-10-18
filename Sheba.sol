/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract Sheba at 0xeeaec5153bc96ba72a8d438d45ea3da1184e66ff
*/
pragma solidity ^0.4.23;

contract PresageFlower {
    
    // Unerasable diary
    struct Diary {
        address author;
        string body;
        uint256 time;
    }
    
    Diary[] diaries;
    mapping(address => bool) authors;
    
    constructor() public {
        authors[msg.sender] = true;
    }
    
    modifier onlyAuthor() {
        require(authors[msg.sender] == true);
        _;
    }
    
    function addAuthor(address _newAuthor) public onlyAuthor {
        authors[_newAuthor] = true;
    }
    
    function removeAuthor(address _otherAuthor) public onlyAuthor {
        require(msg.sender != _otherAuthor);
        authors[_otherAuthor] = false;
    }
    
    function addDiary(string body) public onlyAuthor {
        diaries.push(Diary(msg.sender, body, now));
    }
    
    function getDiary(uint256 idx) public view onlyAuthor returns(address, string, uint256) {
        if(diaries.length > idx) {
            return (diaries[idx].author, diaries[idx].body, diaries[idx].time);
        } else {
            return (0x0, "No Entry.", 0);
        }
    }
    
    function getRecentDiary() public view onlyAuthor returns(address, string, uint256) {
        return getDiary(diaries.length - 1);
    }
    
    function getDiaryLength() public view onlyAuthor returns(uint256) {
        return diaries.length;
    }
}

contract Sheba {
    
    PresageFlower presageFlower;
    
    constructor(address _presageFlower) public {
        presageFlower = PresageFlower(_presageFlower);
    }
    
    function getDiary(uint256 idx) public view returns(address, string, uint256) {
        return presageFlower.getDiary(idx);
    }
    
    function getRecentDiary() public view returns(address, string, uint256) {
        return presageFlower.getRecentDiary();
    }
    
    function getDiaryLength() public view returns(uint256) {
        return presageFlower.getDiaryLength();
    }
    
}