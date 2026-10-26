package br.com.logistica.bff.controller;

import br.com.logistica.bff.clients.ClientesClient;
import br.com.logistica.bff.clients.EntregasClient;
import br.com.logistica.bff.clients.PedidosClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClient;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
public class EntregasController {
    private final EntregasClient entregasClient;
    private final PedidosClient pedidosClient;
    private final ClientesClient clientesClient;

    public EntregasController (EntregasClient entregasClient, PedidosClient pedidosClient,
                               ClientesClient clientesClient){
        this.entregasClient = entregasClient;
        this.pedidosClient = pedidosClient;
        this.clientesClient = clientesClient;
    }

    @GetMapping("/entregas")
    public String listar (){
        return entregasClient.listar();
    }

    @GetMapping("/entregas/{id}")
    public String buscar (@PathVariable String id){
        return entregasClient.buscar(id);
    }

    @GetMapping("/entregas/{id}/detalhe")
    public Map<String, Object> detalhe(@PathVariable String id) {
        Map<String, Object> entrega = entregasClient.buscarMapa(id);
        Map<String, Object> pedido = pedidosClient.buscarMapa((String) entrega.get("pedidoId"));
        Map<String, Object> cliente = clientesClient.buscarMapa((String) pedido.get("clienteId"));

        Map<String, Object> resposta = new LinkedHashMap<>();
        resposta.put("entrega", entrega);
        resposta.put("pedido", pedido);
        resposta.put("cliente", cliente);
        resposta.put("motorista", null);
        return resposta;
    }
}
