/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract Gods at 0xf180e0f0b8ae56f01427817c2627f1fc75202929
*/
pragma solidity ^0.4.2;

/* ???????????? ???????? */
contract Owned {

    /* ????? ????????? ?????????*/
    address owner;

    /* ??????????? ?????????, ?????????? ??? ?????? ??????? */
    function Owned() {
        owner = msg.sender;
    }

    /* ???????? ????????? ?????????, newOwner - ????? ?????? ????????? */
    function changeOwner(address newOwner) onlyowner {
        owner = newOwner;
    }

    /* ??????????? ??? ??????????? ??????? ? ???????? ?????? ??? ????????? */
    modifier onlyowner() {
        if (msg.sender==owner) _;
    }

    /* ??????? ???????? */
    function kill() onlyowner {
        if (msg.sender == owner) suicide(owner);
    }
}

/* ???????? ????????, ????????? ???????? Owned */
contract Gods is Owned {

    /* ????????? ?????????????? ????????? */
    struct Member {
        address member;
        string name;
        string surname;
        string patronymic;
        uint birthDate;
        string birthPlace;
        string avatarHash;
        uint avatarID;
        bool approved;
        uint memberSince;
    }

    /* ?????? ?????????? */
    Member[] public members;

    /* ??????? ????? ????????? -> id ????????? */
    mapping (address => uint) public memberId;

    /* ??????? id ????????? -> ????????? ???? ???????? */
    mapping (uint => string) public pks;

    /* ??????? id ????????? -> ?????????????? ?????? ?? ????????? ? ??????? JSON */
    mapping (uint => string) public memberData;

    /* ??????? ??? ?????????? ?????????, ????????? - ?????, ID */
    event MemberAdded(address member, uint id);

    /* ??????? ??? ????????? ?????????, ????????? - ?????, ID */
    event MemberChanged(address member, uint id);

    /* ??????????? ?????????, ?????????? ??? ?????? ??????? */
    function Gods() {
        /* ????????? ??????? ????????? ??? ????????????? */
        addMember('', '', '', 0, '', '', 0, '');
    }

    /* ??????? ?????????? ? ?????????? ?????????, ????????? - ?????, ???, ???????,
     ????????, ???? ???????? (linux time), ????? ????????, ??? ???????, ID ???????
     ???? ???????????? ? ????? ??????? ?? ??????, ?? ????? ?????? ?????, ? ????? ????????? ???????
     MemberAdded, ???? ???????????? ??????, ?? ????? ??????????? ?????????? ????? ? ?????????? ????
     ????????????? approved */
    function addMember(string name,
        string surname,
        string patronymic,
        uint birthDate,
        string birthPlace,
        string avatarHash,
        uint avatarID,
        string data) onlyowner {
        uint id;
        address member = msg.sender;
        if (memberId[member] == 0) {
            memberId[member] = members.length;
            id = members.length++;
            members[id] = Member({
                member: member,
                name: name,
                surname: surname,
                patronymic: patronymic,
                birthDate: birthDate,
                birthPlace: birthPlace,
                avatarHash: avatarHash,
                avatarID: avatarID,
                approved: (owner == member),
                memberSince: now
            });
            memberData[id] = data;
            if (member != 0) {
                MemberAdded(member, id);
            }
        } else {
            id = memberId[member];
            Member m = members[id];
            m.approved = true;
            m.name = name;
            m.surname = surname;
            m.patronymic = patronymic;
            m.birthDate = birthDate;
            m.birthPlace = birthPlace;
            m.avatarHash = avatarHash;
            m.avatarID = avatarID;
            memberData[id] = data;
            MemberChanged(member, id);
        }
    }

    /* ??????? ????????? ?????????? ????? ?? ID ????? */
    function getPK(uint id) onlyowner constant returns (string) {
        return pks[id];
    }

    /* ??????? ????????? ?????????? ?????? */
    function getMemberCount() constant returns (uint) {
        return members.length - 1;
    }

    /* ??????? ????????? ????? ?? id
     ?????????? ?????? ?? ????? [???, ???????, ????????, ????_????????, ??? ???????, id ???????] */
    function getMember(uint id) constant returns (
        string name,
        string surname,
        string patronymic,
        uint birthDate,
        string birthPlace,
        string avatarHash,
        uint avatarID,
        string data) {
        Member m = members[id];
        name = m.name;
        surname = m.surname;
        patronymic = m.patronymic;
        birthDate = m.birthDate;
        birthPlace = m.birthPlace;
        avatarHash = m.avatarHash;
        avatarID = m.avatarID;
        data = memberData[id];
    }
}