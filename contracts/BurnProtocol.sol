// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
Burn Protocol
Secure ERC20 token burn mechanism
*/

interface IERC20 {
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}

contract BurnProtocol {

    address public constant DEAD_ADDRESS =
        0x000000000000000000000000000000000000dEaD;

    event TokenBurned(
        address indexed user,
        address indexed token,
        uint256 amount
    );

    function burnToken(address token, uint256 amount) external {

        require(token != address(0), "Invalid token address");
        require(amount > 0, "Amount must be greater than zero");

        bool success = IERC20(token).transferFrom(
            msg.sender,
            DEAD_ADDRESS,
            amount
        );

        require(success, "Token transfer failed");

        emit TokenBurned(msg.sender, token, amount);
    }
}
