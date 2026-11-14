package br.com.logistica.estoque.service;

import br.com.logistica.estoque.dto.ItemEstoque;
import br.com.logistica.estoque.exception.NegocioException;
import br.com.logistica.estoque.model.Produto;
import br.com.logistica.estoque.repository.ProdutoRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class EstoqueService {

    private final ProdutoRepository produtoRepository;

    public EstoqueService(ProdutoRepository produtoRepository) {
        this.produtoRepository = produtoRepository;
    }

    @Transactional
    public Produto entrada(ItemEstoque item) {
        validarQuantidade(item.quantidade());
        Produto produto = buscarComLock(item.produtoId());
        produto.setQuantidadeDisponivel(produto.getQuantidadeDisponivel() + item.quantidade());
        return produtoRepository.save(produto);
    }

    @Transactional
    public void reservar(List<ItemEstoque> itens) {
        for (ItemEstoque item : itens) {
            validarQuantidade(item.quantidade());
            Produto produto = buscarComLock(item.produtoId());

            if (produto.getQuantidadeDisponivel() < item.quantidade()) {
                throw new NegocioException("ESTOQUE_INSUFICIENTE",
                        "Estoque insuficiente para o produto " + produto.getNome(),
                        HttpStatus.CONFLICT);
            }

            produto.setQuantidadeDisponivel(produto.getQuantidadeDisponivel() - item.quantidade());
            produto.setQuantidadeReservada(produto.getQuantidadeReservada() + item.quantidade());
            produtoRepository.save(produto);
        }
    }

    @Transactional
    public void liberar(List<ItemEstoque> itens) {
        for (ItemEstoque item : itens) {
            validarQuantidade(item.quantidade());
            Produto produto = buscarComLock(item.produtoId());

            if (produto.getQuantidadeReservada() < item.quantidade()) {
                throw new NegocioException("RESERVA_INSUFICIENTE",
                        "Quantidade reservada menor que a quantidade a liberar para " + produto.getNome(),
                        HttpStatus.CONFLICT);
            }

            produto.setQuantidadeReservada(produto.getQuantidadeReservada() - item.quantidade());
            produto.setQuantidadeDisponivel(produto.getQuantidadeDisponivel() + item.quantidade());
            produtoRepository.save(produto);
        }
    }

    private Produto buscarComLock(UUID id) {
        return produtoRepository.buscarComLock(id)
                .orElseThrow(() -> new NegocioException("PRODUTO_NAO_ENCONTRADO",
                        "Produto não encontrado: " + id, HttpStatus.NOT_FOUND));
    }

    private void validarQuantidade(int quantidade) {
        if (quantidade <= 0) {
            throw new NegocioException("QUANTIDADE_INVALIDA",
                    "A quantidade deve ser maior que zero", HttpStatus.BAD_REQUEST);
        }
    }
}
