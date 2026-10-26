import { useState } from 'react'
import heroImg from './assets/hero.png'
import reactLogo from './assets/react.svg'
import viteLogo from './assets/vite.svg'
import './App.css'

function App() {
  const [clientes, setClientes] = useState([])
    const [detalheEntrega, setDetalheEntrega] = useState(null)
  return (
      <main>
        <h1>Clientes</h1>
        <p>Lista de clientes do sistema de logística.</p>
        <button onClick={carregarClientes}>Carregar clientes</button>
        <ul>
          {clientes.map((cliente) => (
              <li key={cliente.id}>
                {cliente.nome} — {cliente.email}
              </li>
          ))}
        </ul>
          <h2>Detalhe da entrega</h2>
          <button onClick={carregarDetalheEntrega}>
              Carregar entrega
          </button>
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

    async function carregarDetalheEntrega() {
        try {
            const resposta = await fetch(
                'http://localhost:8080/entregas/d1111111-1111-1111-1111-111111111111/detalhe'
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
