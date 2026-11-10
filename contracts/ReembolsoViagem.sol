// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReembolsoViagem {
    
    address public agencia;
    address payable public turista;
    uint public valor;
    bool public cancelado;
    string public mensagem;

    event ReembolsoRealizado(address destinatario, uint valor, string mensagem);

    constructor (address _agencia, address payable _turista, uint _valor, string memory _mensagem) {
        agencia = _agencia;
        turista = _turista;
        valor = _valor;
        cancelado = false;
        mensagem = _mensagem;
    }
    
    function cancelarViagem() public {
        cancelado = true;
        (bool sucesso, ) = turista.call{value: valor}("");
        require(sucesso, "Falha no reembolso");
        emit ReembolsoRealizado(turista, valor, mensagem);
    }
}