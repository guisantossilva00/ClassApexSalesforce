public with sharing class apiCepRest {
    private static final String URL_REMOTE = 'https://cdn.apicep.com/file/apicep/';
    
    @AuraEnabled(cacheable=true)
    public static ApiCepJson.DadosEndereco getCep(String cep) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint(URL_REMOTE + cep +'.json');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        
        
        HttpResponse response = Http.send(request);
        ApiCepJson.DadosEndereco resultado = new ApiCepJson.DadosEndereco();
        
        
        if (response.getStatusCode() == 200) {
            resultado = (apiCepJson.DadosEndereco) JSON.deserialize(response.getBody(),  ApiCepJson.DadosEndereco.class);
            System.debug('resultado ' + resultado);
        } else {
            return null;
        }

        return resultado;
    }

}
