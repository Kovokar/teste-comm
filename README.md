# 🖱️ Projeto de Controle de Mouse e Comunicação WiFi

## 📝 Descrição Geral

Este projeto implementa um dispositivo de controle de mouse avançado usando um microcontrolador ESP32, com funcionalidades inovadoras:

- 🎮 **Controle de Mouse via Joystick**
- 🌐 **Comunicação WiFi Integrada**
- 🔘 **Detecção Inteligente de Botões**
- 🎙️ **Entrada de Microfone**
- 🤖 **Comunicação Direta com Cliente Godot**

## 🔧 Componentes Principais

### 📍 Mapeamento de Pinos

| Pino | Função | Descrição |
|------|--------|-----------|
| `BTA` (5) | Botão A | Entrada digital com pull-up |
| `BTB` (6) | Botão B | Entrada digital com pull-up |
| `MIC` (28) | Microfone | Entrada analógica |
| `switchPin` (22) | Ativar/Desativar Mouse | Botão de controle principal |
| `xAxis` (27) | Joystick Eixo X | Entrada analógica |
| `yAxis` (26) | Joystick Eixo Y | Entrada analógica |

### 🚀 Funcionalidades Principais

#### 📡 Conexão WiFi
- Conexão automática à rede configurada
- Servidor web na porta 80
- Exibição de endereço IP local

#### 🖱️ Controle de Mouse
- **Ativação Dinâmica**: Liga/desliga com botão dedicado
- **Movimentação Precisa**: Leitura vetorial do joystick
- **Clique Integrado**: Suporte a clique do botão do mouse

#### 🤝 Comunicação Godot
- Transmissão de estados de botões
- Detecção de áudio (evento de pulo)
- Protocolo de mensagens bidirecional

## 🛠️ Funções Críticas

| Função | Descrição |
|--------|-----------|
| `deBounce()` | Tratamento anti-interferência de botões |
| `readAxis()` | Processamento de leitura do joystick |
| `setup()` | Inicialização de hardware e conexões |
| `loop()` | Gerenciamento de eventos em tempo real |

## 📋 Requisitos do Projeto

- **Plataforma**: ESP32
- **Bibliotecas Necessárias**:
  - `WiFi`
  - `Mouse`

## ⚙️ Configuração Rápida

1. 🔐 Substituir `"SSID"` e `"PASSWORD"` 
2. 🔌 Verificar compatibilidade de pinos

## 💡 Notas Importantes

- Tratamento de debounce para precisão
- Comunicação via mensagens de texto
- Controle de mouse toggleável
