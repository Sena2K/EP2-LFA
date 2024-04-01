def extrair_enderecos(texto)
  tipo_logradouro_regex = /(?<tipo_logradouro>(Aeroporto|Alameda|Área|Avenida|Campo|Chácara|Colônia|Condomínio|Conjunto|Distrito|Esplanada|Estação|Estrada|Favela|Fazenda|Feira|Jardim|Ladeira|Lago|Lagoa|Largo|Loteamento|Morro|Núcleo|Parque|Passarela|Pátio|Praça|Quadra|Recanto|Residencial|Rodovia|R\.|Setor|Sítio|Travessa|Trecho|Trevo|Vale|Vereda|Via|Viaduto|Viela|Vila|Aer\.|Alam\.|Ár\.|Av\.|Cpo\.|Ch\.|Col\.|Cond\.|Conj\.|Dist\.|Esp\.|Est\.|Estr\.|Fav\.|Faz\.|Feir\.|Jd\.|Lad\.|Lg\.|Lg\.|Lg\.|Lot\.|Morr\.|Núcl\.|Pq\.|Pass\.|Pát\.|Pç\.|Qd\.|Rec\.|Res\.|Rod\.|Set\.|Sit\.|Trav\.|Tr\.|Tv\.|Vl\.|Vd\.|Vl\.|Aeroporto|Alam\.|Área|Av\.|r\.|Campo|Chácara|Col\.|Cond\.|Conj\.|Dist\.|Esplanada|Estação|Estr\.|Favela|Fazenda|Feira|Jardim|Ladeira|Lago|Lagoa|Largo|Loteamento|Morr\.|Núcleo|Parque|Passarela|Pátio|Praça|Quadra|Recanto|Residencial|Rodovia|Rua|Setor|Sítio|Travessa|Trecho|Trevo|Vale|Vereda|Via|Viaduto|Viela|Vila))/i
  nome_logradouro_regex = /\s(?<nome_logradouro>([A-zÀ-ú]+\.?\s*)+)/
  numero_regex = /\,?\s(?<numero>\d+)/
  complemento_regex = /(\s\-\s)*\,?\s?(?<complemento>[A-zÀ-ú]+?\s?\d+?)?/
  bairro_regex = /\,?\s?\-?\s?(?<bairro>([A-zÀ-ú]+\s?)+)?/
  cidade_regex = /\,?\s?(?<cidade>([A-zÀ-ú]+\s?)+)?/
  estado_regex = /\,?\s\-?\s?(?<estado>[A-z]{2})?/
  cep_regex = /\,?\s(?<cep>\d{5}\-\d{3})?/

  enderecos = []

  texto.scan(/#{tipo_logradouro_regex}#{nome_logradouro_regex}#{numero_regex}#{complemento_regex}#{bairro_regex}#{cidade_regex}#{estado_regex}#{cep_regex}/i) do |match|
    tipo_logradouro = match[0]&.strip
    nome_logradouro = match[1]&.strip
    numero = match[2]&.strip
    complemento = match[3]&.strip
    bairro = match[4]&.strip
    cidade = match[5]&.strip
    estado = match[6]&.strip
    cep = match[7]&.strip

    endereco = {
      tipo_logradouro: tipo_logradouro,
      nome_logradouro: nome_logradouro,
      numero: numero,
      complemento: complemento,
      bairro: bairro,
      cidade: cidade,
      estado: estado,
      cep: cep
    }

    enderecos << endereco
  end

  enderecos
end

texto = "At vero eos et accusamus et iusto odio dignissimos ducimus qui Jardim São Luis, 1001 - Bela Vista, São Paulo - SP, 01311-000 blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."
enderecos_encontrados = extrair_enderecos(texto)
if enderecos_encontrados.empty?
  puts "Nenhum endereço encontrado."
else
  enderecos_encontrados.each do |endereco|
    puts "Tipo: #{endereco[:tipo_logradouro]}"
    puts "Nome: #{endereco[:nome_logradouro]}"
    puts "Número: #{endereco[:numero]}"
    puts "Completo: #{endereco[:complemento]}"
    puts "Bairro: #{endereco[:bairro]}"
    puts "Cidade: #{endereco[:cidade]}"
    puts "Estado: #{endereco[:estado]}"
    puts "CEP: #{endereco[:cep]}"
    puts
  end
end
