package br.com.logistica.estoque.controller;

import br.com.logistica.estoque.dto.ItemEstoque;
import br.com.logistica.estoque.model.Produto;
import br.com.logistica.estoque.repository.ProdutoRepository;
import br.com.logistica.estoque.service.EstoqueService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/estoque")
public class EstoqueController {

    private final EstoqueService estoqueService;
    private final ProdutoRepository produtoRepository;

    public EstoqueController(EstoqueService estoqueService, ProdutoRepository produtoRepository) {
        this.estoqueService = estoqueService;
        this.produtoRepository = produtoRepository;
    }

    @GetMapping("/{produtoId}")
    public ResponseEntity<Map<String, Object>> consultar(@PathVariable UUID produtoId) {
        return produtoRepository.findById(produtoId)
                .map(p -> ResponseEntity.ok(resumo(p)))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/entrada")
    public Map<String, Object> entrada(@RequestBody ItemEstoque item) {
        return resumo(estoqueService.entrada(item));
    }

    @PostMapping("/reservar")
    public ResponseEntity<Void> reservar(@RequestBody List<ItemEstoque> itens) {
        estoqueService.reservar(itens);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/liberar")
    public ResponseEntity<Void> liberar(@RequestBody List<ItemEstoque> itens) {
        estoqueService.liberar(itens);
        return ResponseEntity.ok().build();
    }

    private Map<String, Object> resumo(Produto p) {
        Map<String, Object> resposta = new LinkedHashMap<>();
        resposta.put("produtoId", p.getId());
        resposta.put("quantidadeDisponivel", p.getQuantidadeDisponivel());
        resposta.put("quantidadeReservada", p.getQuantidadeReservada());
        return resposta;
    }
}
