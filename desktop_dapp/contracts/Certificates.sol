pragma solidity >=0.4.22 <0.9.0;

contract Certificates {

    constructor() public {}
    // an array of certificate
    mapping(string => mapping(bytes32 => Certificate)) public certificates;
    // we define an array of school address, use to denied unauthorized transaction later on
    address[] private validAddress;
    // intitlize out address here
    address private mainAddress = 0x75302F0F8a5F343946f5b1e9B4b60bd08404fE35;

    struct Certificate {
        string hashAddress;
        string schoolId;
        bytes32 certId;
    }

    event certificateGenerated(bytes32 _certificateId);

    // Add school address so that can add certificate
    function addAddress(address schoolAddress) public {
        require(msg.sender == mainAddress, "You don't have permission!");
        validAddress.push(schoolAddress);
    }

    // Only school's address have access to add certificate
    function checkAccess(address schoolAddress) view private returns (bool) {
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

    function generateCertificate(string memory hashAddress, string memory schoolId) public {
        require(checkAccess(msg.sender), "You dont have apermission");
        bytes32 byte_id = stringToBytes32(hashAddress);
        certificates[schoolId][byte_id] = Certificate(hashAddress, schoolId, byte_id);
        emit certificateGenerated(byte_id);
    }

    function getCertificate(string memory schoolId, bytes32 _id) public view returns (string memory) {
        Certificate memory cert = certificates[schoolId][_id];
        return cert.hashAddress;
    }

}