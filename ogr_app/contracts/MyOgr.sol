// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract MyOgr{
    
    struct ogrenci{
        
        string mail;
        address adr;
        bool deleted;
        bool valited;
    }
    
    mapping(address=>ogrenci) ogrenciler;
    uint limit;
    mapping(uint=>address) ogreIndex;
    address owner;
    bool isActive;
    uint regesteredUsers;
    
    function isRegestered(address _adr) public view returns(bool){
        
        return(ogrenciler[_adr].adr!=address(0) && !ogrenciler[_adr].deleted);
    }
    
    function ogrAdd(string memory _mail) public onlyActice{
        
        require(!isRegestered(msg.sender),"Zaten Kayitlisiniz");
        require(limit>regesteredUsers,"Limit Doldu");
        regesteredUsers++;
        ogrenciler[msg.sender] =ogrenci(_mail,msg.sender,false,false);
        ogreIndex[regesteredUsers]=msg.sender;
    } 
    
    function getOgr(uint _id) public view returns(string memory){
        
        return(ogrenciler[ogreIndex[_id]].mail);
    }
    
    function getUserCount() public view returns(uint){
        
        return(regesteredUsers);
    }
    
    function getActive() public view returns(bool){
        return(isActive);
    }
    
    function setActive(bool _deger) public onlyOwner {
        isActive=_deger;
        
    }
    
    function delOgr(uint _id) public onlyOwner {
        
        ogrenciler[ogreIndex[_id]].deleted=true; regesteredUsers--; //admin
        
    } 
    
    constructor () public{
        owner=msg.sender;
        limit=10;
        
    }
    
    modifier onlyOwner(){
        
        require(owner==msg.sender,'Sadece Kontrat Sahibi Yetkili');
        _;
    }
    
    modifier onlyActice(){
        
        require(isActive,"Kontrat Aktif Degil");
        _;
    }
    
}