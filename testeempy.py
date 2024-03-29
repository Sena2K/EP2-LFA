import re

logradouro =r"(" \
            r"Aeroporto|Alameda|Área|Avenida|Campo|Chácara|Colônia|Condomínio|" \
            r"Conjunto|Distrito|Esplanada|Estação|Estrada|Favela|Fazenda|Feira|" \
            r"Jardim|Ladeira|Lago|Lagoa|Largo|Loteamento|Morro|Núcleo|Parque|" \
            r"Passarela|Pátio|Praça|Quadra|Recanto|Residencial|Rodovia|R(?:a|R.|R|\.s\.)|" \
            r"Setor|Sítio|Travessa|Trecho|Trevo|Vale|Vereda|Via|Viaduto|Viela|Vila|" \
            r"Aer\.|Alam\.|Ár\.|Av\.|Cpo\.|Ch\.|Col\.|Cond\.|Conj\.|Dist\.|Esp\.|" \
            r"Est\.|Estr\.|Fav\.|Faz\.|Feir\.|Jd\.|Lad\.|Lg\.|Lg\.|Lg\.|Lot\.|" \
            r"Morr\.|Núcl\.|Pq\.|Pass\.|Pát\.|Pç\.|Qd\.|Rec\.|Res\.|Rod\.|Set\.|" \
            r"Sit\.|Trav\.|Tr\.|Tv\.|Vl\.|Vd\.|Vl\.|Aeroporto|Alam\.|Área|Av\.|" \
            r"r\.|Campo|Chácara|Col\.|Cond\.|Conj\.|Dist\.|Esplanada|Estação|Estr\.|" \
            r"Favela|Fazenda|Feira|Jardim|Ladeira|Lago|Lagoa|Largo|Loteamento|Morr\.|" \
            r"Núcleo|Parque|Passarela|Pátio|Praça|Quadra|Recanto|Residencial|Rodovia|" \
            r"Rua|Setor|Sítio|Travessa|Trecho|Trevo|Vale|Vereda|Via|Viaduto|Viela|Vila)"

complemento = r"(bloco|Bloco|bc|BC|ap(to|artamento)|Ap(to|artamento)|ala|Ala|andar|Andar|anexo|Anexo|casa|Casa|cobertura|Cobertura|frente|Frente|fundos|Fundos|port(a|ã)o|Port(a|ã)o|pr(e|é)dio|Pr(e|é)dio|quadra|Quadra|sala|Sala|sobrado|Sobrado|sobreloja|Sobreloja|subsolo|Subsolo|t(e|é)rreo|T(e|é)rreo)\s*\d*"
numeros = r'\b(?!(?:\d{8}\b))(?:\d{5}-\d{3}|\d+)\b'
cep = r'\d{5}-?\d{3}'
STATE =  r'(AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO)'
pega_bairro = r'[^\W\d_][\w\s]+?(?=[,-])'


texto = "R. Erotides Nogueira, 124 - NomeNormalDecidade, BA, 47400-000"
texto1 = 'Av. Eng. Eusébio Stevaux, 823 - Santo Amaro, São Paulo - SP, 04696-000'
texto2 = 'Parque Dom Bosco, Ximbica - Pernambuco - PE 04438020'


######### logradouro

matchLogradouro= re.search(logradouro, texto) # busca logradouro
LOGRADOURO = matchLogradouro.group() #pega logradouro
logradouro_posicao_f = matchLogradouro.end()  # Posição final da correspondência logradouro
# Extrair a substring a partir da posição inicial da correspondência
substringLogradouro = texto[logradouro_posicao_f:] #novo texto bigode

##### verifica se tem complemento
matchComplemento = re.search(complemento, texto)
if matchComplemento is not None:
    substring_numero_end = texto[logradouro_posicao_f:matchComplemento.start()]
    NUMERO_END = re.search(numeros, substring_numero_end) #pega nums
    matchnumero = NUMERO_END.group()
    matchNUM_posicao_i = NUMERO_END.start()
    matchNUM_posicao_f = NUMERO_END.end()
    nomeendereco = substring_numero_end[:matchNUM_posicao_i].group()
    COMPLEMENTO = matchComplemento.group()
    new_texto = texto[matchComplemento.end():] #novo texto bigode
else:
    COMPLEMENTO = None
    matchNUM = re.search(numeros, substringLogradouro) #pega nums
    if matchNUM is not None:
        matchnumero = matchNUM.group()
        matchNUM_posicao_i = matchNUM.start()
        matchNUM_posicao_f = matchNUM.end()
        nomeendereco = substringLogradouro[:matchNUM_posicao_i]
        new_texto = substringLogradouro[matchNUM_posicao_f:] #novo texto bigode
    else:
        matchnumero =  None
        matchnomeendereco = re.search(r'[^\W\d_][\w\s]+?(?=[,-])',texto[logradouro_posicao_f:])
        nomeendereco = matchnomeendereco.group()
        new_texto = texto[logradouro_posicao_f:][matchnomeendereco.end():]


## procura primeira sequencia de numeros que não seja 8 numeros
    
    
######### nome endereço

######### volta a usar o texto do numero pra frente

##### se tem sigla uso a sigla de referencia 
### logica pra ver onde o endereço acaba?

matchCEP = re.search(cep, new_texto)
matchSTATE = re.search(STATE, new_texto)
## verifica qual que termina o adress
if matchCEP and matchSTATE is not None:
    if matchCEP.end() > matchSTATE.end():
        substringFIMParcial = new_texto[:matchSTATE.start()] 
    elif matchSTATE.end() > matchCEP.end():
        substringFIMParcial = new_texto[:matchCEP.start()]


matchbairro = re.search(pega_bairro, substringFIMParcial)

matchCidade = substringFIMParcial[matchbairro.end():]


print(f"Logradouro Tipo: {LOGRADOURO}\nLogradouro Nome: {nomeendereco}\nNumero:{matchnumero}\nComplemento: {COMPLEMENTO}\nBairro: {matchbairro.group()}\nCidade: {matchCidade}\nEstado: {matchSTATE.group()}\nCEP: {matchCEP.group()}")





