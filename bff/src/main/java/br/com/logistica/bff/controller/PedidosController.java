package br.com.logistica.bff.controller;

import br.com.logistica.bff.clients.PedidosClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PedidosController {
    private final PedidosClient pedidosClient;

    public PedidosController(PedidosClient pedidosClient) {
        this.pedidosClient = pedidosClient;
    }

    @GetMapping("/pedidos")
    public String listar() {
        return pedidosClient.listar();
    }

    @GetMapping("/pedidos/{id}")
    public String buscar(@PathVariable String id) {
        return pedidosClient.buscar(id);
    }
}