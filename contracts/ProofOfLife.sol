// SPDX-License-Identifier: MIT
pragma solidity ^0.8.00;

contract ProofOfLifeService{

    struct Documento{
    string CDN;
    bytes32 hashCDN;
    string LinkCDN;
    uint256 dataRegistro;
    uint256 dataValidade;
    address autor;
    bool registrado;
    }
    
    // Mapeia o hash único do arquivo para os dados do Documento
    mapping(bytes32 => Documento) private documentos;
    
    // Evento emitido na blockchain sempre que um novo CDN é salvo
    event DocumentoCadastrado(
        bytes32 indexed hashCDN,
        string CDN,
        address indexed autor,
        uint256 dataRegistro
    );
    
    // funcao para cadastrar o Documento de Obito ou DO
    function CadastrarDO(
        string memory _DO,
        bytes32 _hashDO,
        string memory _LinkDO,
        uint256 _validade
    )public {
        require(bytes(_DO).length > 0, "O Documento de Obito deve ser preenchido");
        require(_hashDO != bytes32(0), "O hash do arquivo e invalido");

         if (documentos[_hashDO].registrado) {
            revert("Este documento ja esta cadastrado na blockchain");

        }

        // Salva o documento no mapping
        documentos[_hashDO] = Documento({
            CDN: _DO,
            hashCDN: _hashDO,
            LinkCDN: _LinkDO,
            dataRegistro: block.timestamp,
            dataValidade: _validade,
            autor: msg.sender,
            registrado: true
        });

        //emite a confirmação do DO
        emit DocumentoCadastrado(_hashDO, _DO,msg.sender, block.timestamp);
    }
}