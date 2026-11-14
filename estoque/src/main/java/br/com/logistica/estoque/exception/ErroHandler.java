package br.com.logistica.estoque.exception;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

@RestControllerAdvice
public class ErroHandler {

    @ExceptionHandler(NegocioException.class)
    public ResponseEntity<Map<String, String>> tratar(NegocioException e) {
        return ResponseEntity.status(e.getStatus())
                .body(Map.of("codigo", e.getCodigo(), "mensagem", e.getMessage()));
    }
}
