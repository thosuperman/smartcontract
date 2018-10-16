/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract ethworld at 0xA645A748c84DcC2D092b4BcE4196d85147b93a18
*/
pragma solidity ^0.4.18;

/*
???�????�?????????
???2018-03-20
 */

contract ethworld {
    string public ProjectName="????";
    string public ProjectTag="????";  //????,????,????

    string public Descript="???tjiace.com ??:?????????181??????????1505? ??:022-27371166 E-mail?info@tjiace.com ???????International Academy of Creative Education, IACE?, ??????????????????(UCA)????????????(BCU)???????????????????????????????????(IACE)?????????????????????????????????????????????????????????????????(IACE)?????????????????????????????????????????????????????????????????????????????????????????????????????????";
    string[] public Images;
    address public ProjectOwner;

//    event loginfo(address fromaddr,address toaddr,string info);
    
    modifier OnlyOwner() { // Modifier
        require(msg.sender == ProjectOwner);
        _;
    }   
    
    function ethworld() public {
        ProjectOwner=msg.sender;
    }
    
    function SetProjectName(string NewProjectName) OnlyOwner public {
        if(bytes(ProjectName).length==0) ProjectName = NewProjectName;
    }

    function SetProjectTag(string NewTag) OnlyOwner public {
        if(bytes(ProjectTag).length==0) ProjectTag = NewTag;
    }
    
    //set description
    function SetDescript(string NewDescript) OnlyOwner public{ 
        Descript=NewDescript;
    }

    //insert imagimage
    function InsertImage(string ImageAddress) OnlyOwner public{
        Images.push(ImageAddress);
    }
        //changeimage
    function ChangeImage(string ImageAddress,uint index) OnlyOwner public{
        if(index<Images.length)
        {
            Images[index]=ImageAddress;
        }
    }
    
    //del image
    function DeleteImage(uint index) OnlyOwner public{
        if(index<Images.length)
        {
            for(uint loopindex=index;loopindex<(Images.length-1);loopindex++)
            {
                Images[loopindex]=Images[loopindex+1];
            }
            Images.length--;
        }
    }
    
    //change owner of ethworld content
    function ChangeOwner(address newowner) OnlyOwner public{
//        loginfo(owner,newowner,"??????(DAPP)???");
        ProjectOwner=newowner;
    }

    //kill this
    function KillContracts() OnlyOwner public{
//        loginfo(msg.sender,0,"??????(DAPP)");
        selfdestruct(msg.sender);
    }
    
    
//the end
}