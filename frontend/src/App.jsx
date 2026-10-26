import { useState } from 'react'
import heroImg from './assets/hero.png'
import reactLogo from './assets/react.svg'
import viteLogo from './assets/vite.svg'
import './App.css'

function App() {
  const [clientes, setClientes] = useState([])

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
}

export default App
