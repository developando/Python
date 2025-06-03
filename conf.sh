#!/bin/bash

ARQUIVO_CONFIGURACAO="conf.cf"
USAR_CORES=
USAR_MAIUSCULA=
MENSAGEM="Mensagem de teste"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"

DefinirParametros (){                                                                                
    local parametro="$(echo "$1" | cut -d "=" -f 1)"
    local valor="$(echo "$1" |cut -d "=" -f 2)"
    case "${parametro}" in
        USAR_CORES)     USAR_CORES="${valor}"     ;;
        USAR_MAIUSCULA) USAR_MAIUSCULA="${valor}" ;;
    esac
}

[ ! -r "$ARQUIVO_CONFIGURACAO" ] && echo "Não temos acesso de leitura" && exit 1

while read -r linha
do
    [ "$(echo "${linha}" | cut -c1)" = "#" ] && continue
    [ ! "${linha}" ] && continue
    DefinirParametros ${linha}
done < "$ARQUIVO_CONFIGURACAO"

[ ${USAR_MAIUSCULA} = "1" ] &&  MENSAGEM=$(echo -e "${MENSAGEM}"| tr a-z A-Z)
[ ${USAR_CORES} = "1" ] &&  MENSAGEM=$(echo -e "${VERDE}${MENSAGEM}")
[ ${USAR_CORES} = "2" ] &&  MENSAGEM=$(echo -e "${VERMELHO}${MENSAGEM}")

echo $MENSAGEM


