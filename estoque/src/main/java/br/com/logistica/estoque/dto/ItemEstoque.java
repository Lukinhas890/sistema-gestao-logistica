package br.com.logistica.estoque.dto;

import java.util.UUID;

public record ItemEstoque(UUID produtoId, int quantidade) {
}
