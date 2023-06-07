public with sharing class PokeApi {
    private static final String URL_REMOTE = 'https://pokeapi.co/api/v2/pokemon?limit=50&offset=0';
    
    
    private static HttpResponse getUrl(String URL) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint(URL);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        
        HttpResponse response = http.send(request);
        
        return response;
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>>  getPokemons() {
        HttpResponse resPokemons = getUrl(URL_REMOTE);

        List<Map<String, Object>> pokemonsCompleto = new List<Map<String, Object>>();

        if(resPokemons.getStatusCode() == 200) {
            Map<String, Object> pokemonsSimples = (Map<String, Object>)JSON.deserializeUntyped(resPokemons.getBody());
            
            List<Object> pokemonsList = (List<Object>)pokemonsSimples.get('results');

            for(Object pokemon : pokemonsList) {
                Map<String, Object> mapPokemon = (Map<String, Object>)pokemon;

                HttpResponse resPokemon = getUrl((String)mapPokemon.get('url'));

                if(resPokemon.getStatusCode() == 200) {
                    pokemonsCompleto.add((Map<String, Object>)JSON.deserializeUntyped(resPokemon.getBody()));
                }
            }
        }
	
        if(!pokemonsCompleto.isEmpty()) {
            return pokemonsCompleto;
        } else{
            return null;
        }
    }
}