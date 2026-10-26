import { useState } from 'react'
import heroImg from './assets/hero.png'
import reactLogo from './assets/react.svg'
import viteLogo from './assets/vite.svg'
import './App.css'

function App() {
  const [clientes, setClientes] = useState([])
    const [detalheEntrega, setDetalheEntrega] = useState(null)
    const [entregas, setEntregas] = useState([])
    async function carregarEntregas() {
        try {
            const resposta = await fetch('http://localhost:8080/entregas')

            if (!resposta.ok) {
                throw new Error(`Erro HTTP ${resposta.status}`)
            }

            const dados = await resposta.json()
            setEntregas(dados)
        } catch (erro) {
            console.error('Não foi possível carregar as entregas:', erro)
        }
    }
  return (
      <main>
        <h1>Acompanhamento de entregas</h1>
        <p>Consulte as entregas e veja os dados do pedido e do cliente</p>
          <h2>Clientes</h2>
        <button onClick={carregarClientes}>Carregar clientes</button>
        <ul>
          {clientes.map((cliente) => (
              <li key={cliente.id}>
                {cliente.nome}: {cliente.email}
              </li>
          ))}
        </ul>
          <h2>Acompanhar entregas</h2>
          <p>Carregue as entregas e escolha uma para consultar os detalhes.</p>
          <button onClick={carregarEntregas}>Carregar entregas</button>

          <ul>
              {entregas.map((entrega, indice) => (
                  <li key={entrega.id}>
                      Entrega {indice + 1}: {entrega.status}{' '}
                      <button onClick={() => carregarDetalheEntrega(entrega.id)}>
                          Ver detalhes
                      </button>
                  </li>
              ))}
          </ul>
          {detalheEntrega && (
              <section>
                  <h3>Entrega consultada</h3>
                  <p>Status da entrega: {detalheEntrega.entrega.status}</p>
                  <p>Status do pedido: {detalheEntrega.pedido.status}</p>
                  <p>Cliente: {detalheEntrega.cliente.nome}</p>
                  <p>E-mail: {detalheEntrega.cliente.email}</p>
              </section>
          )}
      </main>
  )

  async function carregarClientes() {
    try {
      const resposta = await fetch('http://localhost:8080/clientes')

      if (!resposta.ok) {
        throw new Error(`Erro HTTP ${resposta.status}`)
      }

      const dados = await resposta.json()
      setClientes(dados)
    } catch (erro) {
      console.error('Não foi possível carregar os clientes:', erro)
    }
  }

    async function carregarDetalheEntrega(id) {
        try {
            const resposta = await fetch(
                `http://localhost:8080/entregas/${id}/detalhe`
            )

            if (!resposta.ok) {
                throw new Error(`Erro HTTP ${resposta.status}`)
            }

            const dados = await resposta.json()
            setDetalheEntrega(dados)
        } catch (erro) {
            console.error('Não foi possível carregar a entrega:', erro)
        }
    }
}

export default App
