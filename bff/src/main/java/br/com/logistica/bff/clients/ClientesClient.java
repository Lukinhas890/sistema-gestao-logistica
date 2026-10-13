package br.com.logistica.bff.clients;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

@Component
public class ClientesClient {
    private final RestClient restClient;

    public ClientesClient (RestClient restClient){
        this.restClient = restClient;
    }

    public String listar() {
        return restClient.get().uri("/clientes").retrieve().body(String.class);
    }

    public String buscar(String id) {
        return restClient.get().uri("/clientes/{id}", id).retrieve().body(String.class);
    }

}
