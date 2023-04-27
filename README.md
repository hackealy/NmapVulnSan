Neste exemplo, o script começa realizando o escaneamento de portas e serviços de todos os hosts da rede especificada com o nmap, utilizando a opção "-sS" para fazer um escaneamento stealthy, "-sV" para identificar os serviços que estão rodando nas portas abertas, "-p-" para escanear todas as portas, "-T4" para definir a velocidade de execução e "-oA" para salvar o resultado em três formatos diferentes.

Em seguida, o script utiliza o Metasploit para identificar os módulos de exploit correspondentes aos serviços e portas encontrados na etapa anterior em cada host, e executa os módulos de exploit correspondentes, se houver algum disponível.

--------------------------------------------------------------------------------------------------------

Para executar o script, siga os seguintes passos:

Abra o terminal no diretório onde o script foi salvo.
Dê permissão de execução para o script com o comando "chmod +x nscan.sh".
Execute o script com o comando "./nscan.sh <rede> <arquivo_saida_nmap>".
  
  ex: ./nscan.sh 192.168.0.0/24 saida_nmap
