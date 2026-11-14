$base = "http://127.0.0.1:8084"
$json = "application/json"

$sku = "FUR-" + (Get-Random -Maximum 99999)
$p = Invoke-RestMethod -Method Post -Uri "$base/produtos" -ContentType $json `
  -Body (@{ nome = "Furadeira 500W"; sku = $sku; preco = 249.00; quantidadeDisponivel = 10 } | ConvertTo-Json)
$id = $p.id
"Produto criado: $id"

Invoke-RestMethod -Method Post -Uri "$base/estoque/entrada" -ContentType $json `
  -Body (@{ produtoId = $id; quantidade = 5 } | ConvertTo-Json)

Invoke-RestMethod -Method Post -Uri "$base/estoque/reservar" -ContentType $json `
  -Body (ConvertTo-Json @(@{ produtoId = $id; quantidade = 3 }))
Invoke-RestMethod "$base/estoque/$id"

try {
  Invoke-RestMethod -Method Post -Uri "$base/estoque/reservar" -ContentType $json `
    -Body (ConvertTo-Json @(@{ produtoId = $id; quantidade = 100 }))
} catch {
  "Status: " + $_.Exception.Response.StatusCode.value__
}
Invoke-RestMethod "$base/estoque/$id"

Invoke-RestMethod -Method Post -Uri "$base/estoque/liberar" -ContentType $json `
  -Body (ConvertTo-Json @(@{ produtoId = $id; quantidade = 3 }))
Invoke-RestMethod "$base/estoque/$id"