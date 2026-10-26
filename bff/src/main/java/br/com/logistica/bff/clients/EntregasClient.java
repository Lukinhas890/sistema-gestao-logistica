package br.com.logistica.bff.clients;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import java.util.Map;

@Component
public class EntregasClient {
    private final RestClient restClient;

    public EntregasClient(@Qualifier("entregasRestClient") RestClient restClient) {
        this.restClient = restClient;
    }

    public String listar() {
        return restClient.get().uri("/entregas").retrieve().body(String.class);
    }

    public String buscar(String id) {
        return restClient.get().uri("/entregas/{id}", id).retrieve().body(String.class);
    }

    public Map<String, Object> buscarMapa(String id) {
        return restClient.get().uri("/entregas/{id}", id).retrieve()
                .body(new ParameterizedTypeReference<Map<String, Object>>() {});
    }
}
