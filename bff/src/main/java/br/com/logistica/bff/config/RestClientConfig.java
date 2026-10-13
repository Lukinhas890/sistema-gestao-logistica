package br.com.logistica.bff.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestClient;

@Configuration
public class RestClientConfig {

    @Bean
    public RestClient clientesRestClient (@Value("${servicos.clientes.url}") String url){
        return RestClient.builder().baseUrl(url).build();
    }

}
