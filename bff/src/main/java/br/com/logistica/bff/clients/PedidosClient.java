package br.com.logistica.bff.clients;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import java.util.Map;

@Component
public class PedidosClient {
    private final RestClient restClient;

    public PedidosClient(@Qualifier("pedidosRestClient") RestClient restClient) {
        this.restClient = restClient;
    }

    public String listar() {
        return restClient.get().uri("/pedidos").retrieve().body(String.class);
    }

    public String buscar(String id) {
        return restClient.get().uri("/pedidos/{id}", id).retrieve().body(String.class);
    }

    public Map<String, Object> buscarMapa(String id) {
        return restClient.get().uri("/pedidos/{id}", id).retrieve()
                .body(new ParameterizedTypeReference<Map<String, Object>>() {});
    }
}
