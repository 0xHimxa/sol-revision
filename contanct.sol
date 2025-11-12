// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Savecontact {
    struct UserInfo {
        string name;
        string number;
        string email;
      
    }

    UserInfo[] public userInfo;
   

mapping(string => UserInfo) public userInfoByName;

    function createUser(
        string memory _name,
        string memory _number,
        string memory _email
      
    ) public {
        UserInfo memory user = UserInfo({
            name: _name,
            number: _number,
            email: _email
        });

        userInfo.push(user);
        userInfoByName[_name] = user;

    }
}
