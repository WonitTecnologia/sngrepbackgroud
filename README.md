# README

## Script de Captura de Pacotes Xcontact

Este projeto contém scripts para configurar e gerenciar a captura de pacotes usando a ferramenta `sngrep`. Ele permite iniciar, temporizar e finalizar capturas de pacotes de rede com facilidade.

### Estrutura do Projeto

1. **Script de Instalação (`install.sh`)**
   - Cria um diretório `/xcontactrouble`.
   - Cria um script Python `captura_processo.py` dentro do diretório `/xcontactrouble`.
   - Define permissões de execução para o script Python.
   - Cria um executável `xcontactcaptura` no diretório `/usr/bin`.
   - Define permissões de execução para o executável.

2. **Script Python (`captura_processo.py`)**
   - Menu interativo para escolher a operação de captura.
   - Opções para iniciar a captura em background, temporizar a captura, e finalizar capturas em execução.

3. **Executável (`xcontactcaptura`)**
   - Executa o script Python com permissões de superusuário.

### Instruções de Instalação

1. Salve o script de instalação (`install.sh`) em um arquivo.
2. Execute o script de instalação com permissões de superusuário:
   ```bash
   sudo bash install.sh
   ```
3. Após a execução do script, o comando xcontactcaptura estará disponível para iniciar o script de captura.

### Uso do Script de Captura
1. **Iniciar o Script
   ```bash
   xcontactcaptura
   ```
2. **Menu de Captura

## O menu interativo apresenta as seguintes opções:
- **Deixar em background a captura**
  - Inicia a captura em background.
- **Deixar em x/s em captura**
  - Inicia a captura por um período determinado.
- **Finalizar captura aberta atualmente**
  - Finaliza todos os processos de captura em execução.
- **Sair**
  - Sai do script.

## Detalhes das Funções

- **capture_background()**
  - Solicita confirmação do usuário.
  - Permite escolher o local de salvamento do arquivo de captura.
  - Inicia a captura em background utilizando nohup.

- **choose_location()**
  - Permite ao usuário escolher entre o diretório atual ou um diretório específico para salvar a captura.

- **capture_timed()**
  - Solicita ao usuário o tempo de captura em segundos.
  - Permite escolher o local de salvamento.
  - Inicia a captura temporizada utilizando timeout.

- **capture_kill()**
  - Solicita confirmação do usuário.
  - Lista os processos de captura em execução.
  - Finaliza todos os processos de captura utilizando pkill.

### Permissões

O script `xcontactcaptura` e `captura_processo.py` precisam ser executados com permissões de superusuário (`sudo`) para iniciar e finalizar capturas de rede.

###Observações

- Certifique-se de que o `sngrep` está instalado no sistema.
- Verifique se você possui permissões adequadas para criar arquivos em `/usr/bin` e `/xcontactrouble`.

Este projeto facilita a gestão de capturas de pacotes de rede, tornando o processo mais intuitivo e automatizado.
