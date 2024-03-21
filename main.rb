# regex pra pegar apenas o logradouro, perguntar pro celso se é pra fazer generico ou especifico assim
logradouro = /Aeroporto|Alameda|Área|Avenida|Campo|Chácara|Colônia|Condomínio|Conjunto|Distrito|Esplanada|Estação|Estrada|Favela|Fazenda|Feira|Jardim|Ladeira|Lago|Lagoa|Largo|Loteamento|Morro|Núcleo|Parque|Passarela|Pátio|Praça|Quadra|Recanto|Residencial|Rodovia|Rua|Setor|Sítio|Travessa|Trecho|Trevo|Vale|Vereda|Via|Viaduto|Viela|Vila|Aer\.|Alam\.|Ár\.|Av\.|Cpo\.|Ch\.|Col\.|Cond\.|Conj\.|Dist\.|Esp\.|Est\.|Estr\.|Fav\.|Faz\.|Feir\.|Jd\.|Lad\.|Lg\.|Lg\.|Lg\.|Lot\.|Morr\.|R\.|Núcl\.|Pq\.|Pass\.|Pát\.|Pç\.|Qd\.|Rec\.|Res\.|Rod\.|Set\.|Sit\.|Trav\.|Tr\.|Tv\.|Vl\.|Vd\.|Vl\.|Aeroporto|Alam\.|Área|Av\.|r\.|Campo|Chácara|Col\.|Cond\.|Conj\.|Dist\.|Esplanada|Estação|Estr\.|Favela|Fazenda|Feira|Jardim|Ladeira|Lago|Lagoa|Largo|Loteamento|Morr\.|Núcleo|Parque|Passarela|Pátio|Praça|Quadra|Recanto|Residencial|Rodovia|Rua|Setor|Sítio|Travessa|Trecho|Trevo|Vale|Vereda|Via|Viaduto|Viela|Vila/i


#texto teste
texto = "Vila dos Girassóis"

# primeira ideia de como guardar o logradouro
tipo_logradouro = texto.match(logradouro) ? texto.match(logradouro)[0] : "Não encontrado"

puts tipo_logradouro