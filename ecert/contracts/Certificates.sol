pragma solidity >=0.4.22 <0.9.0;

contract Certificates {

    constructor() public {}
    // an array of certificate
    mapping(bytes32 => Certificate) public certificates;
    // we define an array of school address, use to denied unauthorized transaction later on
    address[] private validAddress;
    // our address 
    address private mainAddress = 0x75302F0F8a5F343946f5b1e9B4b60bd08404fE35;
    
    struct Certificate {
        string hashAddress;
    }

    event certificateGenerated(bytes32 _certificateId);
    
    function addAddress(address schoolAddress) public {
        require(msg.sender == mainAddress, "You don't have permission!");
        validAddress.push(schoolAddress);
    }
    
    function checkAccess(address schoolAddress) view private returns (bool) {
        if (schoolAddress == mainAddress) return true;
        for (uint256 u = 0; u < validAddress.length; ++u) {
            if (validAddress[u] == schoolAddress) return true;
        }
        return false;
    }

    function stringToBytes32(string memory source) private pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
                result := mload(add(source, 32))
        }
    }

    function generateCertificate(string memory hashAddress) public {
        // require(checkAccess(msg.sender), "You dont have apermission");
        bytes32 byte_id = stringToBytes32(hashAddress);
        certificates[byte_id] = Certificate(hashAddress);
        emit certificateGenerated(byte_id);
    }

    function getCertificate(string memory _id) public view returns (string memory) {
        bytes32 byte_id = stringToBytes32(_id);
        Certificate memory cert = certificates[byte_id];
        return cert.hashAddress;
    }

    function testGet(bytes32 _id) public view returns (string memory) {
        Certificate memory cert = certificates[_id];
        return cert.hashAddress;
    }

}