public with sharing class PokeController {
    
    @AuraEnabled
    public static String insertPokemon(String name, String idPokemon, String altura, String peso, String urlImage, Integer experienciaBase, List<String> tipos, Integer hp, Integer atq, Integer def, Integer atqEspecial, Integer defEspecial, Integer velocidade) {
        try {
            MeuPokemon__c novoPokemon = new MeuPokemon__c(); 
            String tiposFormatados = '';

            for(Integer i = 0; i < tipos.size(); i++) {
                tiposFormatados += i + 1 != tipos.size() ? tipos[i] + ';': tipos[i];
            }

            novoPokemon.Name = name;
            novoPokemon.IdPokemon__c = idPokemon;
            novoPokemon.Altura__c = altura;
            novoPokemon.Peso__c = peso;
            novoPokemon.UrlImagem__c = urlImage;
            novoPokemon.ExperienciaBase__c = experienciaBase;
            novoPokemon.TipoPokemon__c = tiposFormatados;
            novoPokemon.HP__c = hp;
            novoPokemon.Ataque__c = atq;
            novoPokemon.Defesa__c = def;
            novoPokemon.AtaqueEspecial__c = atqEspecial;
            novoPokemon.DefesaEspecial__c = defEspecial;
            novoPokemon.Velocidade__c = velocidade;

            insert novoPokemon;   

            insertHistoricoCaptura(novoPokemon.Name, novoPokemon.UrlImagem__c, 'Capturado');
            return novoPokemon.Id;      
        } catch (Exception ex) {
            return null;
        }
    }

    @AuraEnabled
    public static void insertHistoricoCaptura(String nome, String urlImagem, String status) {
      
            HistoricoCapturas__c novoHistoricoCaptura = new HistoricoCapturas__c();

            novoHistoricoCaptura.NomePokemon__c = nome;
            novoHistoricoCaptura.Status__c = status;
            novoHistoricoCaptura.DataHora__c = Datetime.now();
            novoHistoricoCaptura.UrlImagem__c = urlImagem;
            
            insert novoHistoricoCaptura;     
    }
}