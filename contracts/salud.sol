// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract IDS{
    address public  medico; //almacena nuestro hash

    //crear el constructor (usado para delimitar la estructura de nuestro código

    constructor()
    {
        medico= msg.sender; //hace que ese dato lo obtenga de la billetera o metamask
    }

   //Mapping para relacionar los hash con los datos del paciente
   mapping (bytes32 =>string) RegistrosNombres; 
   mapping (bytes32 =>uint) RegistrosPeso; 
   mapping (bytes32 =>uint) RegistrosAltura;  

   //Evento
   event paciente_atendido(bytes32,string,uint,uint);

   //Funcion para registrar los datos de los pacientes
   function AtenderPacientes(string memory _idPaciente,string memory _nombrePaciente, uint _peso, uint _altura) public UnicamenteMedico(msg.sender) {
        //haSh del paciente
        bytes32 hash_idPaciente= keccak256(abi.encodePacked(_idPaciente));

        //Mapping del HASH del paciente con sus datos

        RegistrosNombres[hash_idPaciente]=_nombrePaciente;
        RegistrosPeso[hash_idPaciente]=_peso;
        RegistrosAltura[hash_idPaciente]=_altura;

        //Emitir el evento como un retorno

        emit paciente_atendido(hash_idPaciente, _nombrePaciente, _peso, _altura);
   }

   //Para que solo el médico pueda ejecutar la funcion definida

   modifier UnicamenteMedico(address _direccion){
        require(_direccion == medico, "Solo el medico tiene permisos para crear registros de pacientes");
        _;
   }
}