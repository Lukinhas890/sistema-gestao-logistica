package br.com.logistica.bff.controller;

import br.com.logistica.bff.clients.ClientesClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ClientesController {
    private final ClientesClient clientesClient;

    public ClientesController (ClientesClient clientesClient){
        this.clientesClient = clientesClient;
    }

    @GetMapping("/clientes")
    public String listar (){
        return clientesClient.listar();
    }

    @GetMapping("/clientes/{id}")
    public String buscar (@PathVariable String id){
        return clientesClient.buscar(id);
    }
}
