#!/bin/bash

# Cria a pasta /xcontactrouble se ainda não existir
mkdir -p /xcontactrouble

# Cria o arquivo captura_processo.py com o código fornecido
cat << 'EOF' > /xcontactrouble/captura_processo.py
# -*- coding: utf-8 -*-
import os
import subprocess
import time
import datetime

def capture_menu():
    print("Captura menu Xcontact")
    print("1 - Deixar em background a captura")
    print("2 - Deixar em x/s em captura")
    print("3 - Finalizar captura aberta atualmente")
    print("4 - Sair")
    choice = raw_input("Escolha uma opcao: ")
    if choice == '1':
        capture_background()
    elif choice == '2':
        capture_timed()
    elif choice == '3':
        capture_kill()
    elif choice == '4':
        exit(0)
    else:
        print("Opcao invalida.")

def capture_background():
    confirmation = raw_input("Tem certeza que deseja iniciar a captura em background? (s/n): ")
    if confirmation.lower() == 's':
        location = choose_location()
        if location:
            data_time = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
            command = "sudo nohup sngrep -c -r -O {}/cap{}.pcap > /dev/null 2>&1 &".format(location, data_time)
            pid = subprocess.Popen(command, shell=True).pid
            print("A captura foi iniciada em background com PID:", pid)
            print("A captura esta sendo salva em:", location+"/cap"+data_time+".pcap")

def choose_location():
    choice = raw_input("Deseja salvar a captura no local atual (1) ou escolher um local (2)? ")
    if choice == '1':
        return os.getcwd()
    elif choice == '2':
        location = raw_input("Informe o local completo onde deseja salvar (deve comecar com '/'): ")
        if os.path.exists(location):
            return location
        else:
            print("Local especificado nao existe.")
            return None
    else:
        print("Opcao invalida.")
        return None

def capture_timed():
    seconds = int(raw_input("Quantos segundos deseja deixar a captura em execucao? "))
    location = choose_location()
    if location:
        data_time = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        command = "sudo nohup timeout {}s sngrep -c -r -O {}/cap{}.pcap >/dev/null 2>&1 &".format(seconds, location, data_time)
        pid = subprocess.Popen(command, shell=True).pid
        print("A captura foi iniciada por", seconds, "segundos com PID:", pid)
        print("A captura esta sendo salva em:", location+"/cap"+data_time+".pcap")

def capture_kill():
    confirmation = raw_input("Tem certeza que deseja finalizar todos os processos de captura? (s/n): ")
    if confirmation.lower() == 's':
        # Lista os processos que correspondem ao padrão "sngrep -c -r -O"
        command_list = "ps aux | grep 'sngrep -c -r -O'"
        output = subprocess.check_output(command_list, shell=True)
        print("Processos encontrados:")
        print(output.decode())  # Imprime a saída decodificada
        
        # Finaliza os processos correspondentes
        command_kill = "sudo pkill -f 'sngrep -c -r -O'"
        subprocess.Popen(command_kill, shell=True)
        print("Todos os processos que contêm captura foram finalizados.")

if __name__ == "__main__":
    capture_menu()
EOF

# Define as permissões corretas para o script
chmod +x /xcontactrouble/captura_processo.py

# Cria o executável xcontactcaptura no diretório /usr/bin
cat << 'EOF' > /usr/bin/xcontactcaptura
#!/bin/bash
sudo python /xcontactrouble/captura_processo.py
EOF

# Define as permissões corretas para o executável
chmod +x /usr/bin/xcontactcaptura

echo "Instalação concluída. O comando 'xcontactcaptura' está disponível para executar o script."
