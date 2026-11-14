package br.com.logistica.estoque.exception;

import org.springframework.http.HttpStatus;

public class NegocioException extends RuntimeException {

    private final String codigo;
    private final HttpStatus status;

    public NegocioException(String codigo, String mensagem, HttpStatus status) {
        super(mensagem);
        this.codigo = codigo;
        this.status = status;
    }

    public String getCodigo() { return codigo; }
    public HttpStatus getStatus() { return status; }
}
