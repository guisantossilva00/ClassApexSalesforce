global without sharing class emailController {

    public static void getEnviarEmail(String CompanyName, String CNPJ, String InscricaoEM, String Phone, String lastname, String Endereco,
                                    String CEP, String Numero, String Bairro, String Cidade, String Estado, String EnderecoEntrega, String CEPEntrega,
                                    String NumeroEntrega, String BairroEntrega, String CidadeEntrega, String EstadoEntrega, String email,string accountId ) {
    
        // Buscar um modelo de email em 'Modelos de email do Classic'
        EmailTemplate et = [SELECT Id, HtmlValue, Subject FROM EmailTemplate WHERE DeveloperName = 'ModeloEmail'];
                                        
        // Buscar o usuário que vai receber o email
        User user = [SELECT Id, Email, FirstName, LastName FROM User WHERE Email = 'emaildousuario@email.com' LIMIT 1];
    
        // Instânciando o Messaging.SingleEmailMessage para recerber o Messaging.renderStoredEmailTemplate(Id do Template, Id do Usuário, geralmente o id conta ou oportunidade. )
        Messaging.SingleEmailMessage enviarEmail = Messaging.renderStoredEmailTemplate(et.Id, user.Id, accountId);
        
        // Os emails das pessoas que vão receber o email
        enviarEmail.setToAddresses(new List<String>{'email1@email.com','email2@email.com', 'email3@email.com', 'email4@email.com'});
       
        // Assunto do Email
        enviarEmail.setSubject('Pendência de cadstro: ' + CompanyName);

        // Id do usuário que fez a busca
        enviarEmail.setTargetObjectId(user.Id);

        // False para não rastrear a abertura dos emails
        enviarEmail.saveAsActivity = false;

        // email que vai receber a resposta, caso o usuário responda o email que recebeu
        enviarEmail.setReplyTo('support@uisa.com');

        // busca do email padrão da organização que será defenido como quem enviou o email automático
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = ' OrgWideEmailAddress@orgemail.com'];        
        
        if ( owea.size() > 0 ) {
            system.debug(owea[0].Id);

            // defenindo o email que vai aparecer como quem enviou, passando o seu id
            enviarEmail.setOrgWideEmailAddressId(owea[0].Id);
        }            
                         
        // Modificando o texto do email que veio do template, para receber o valor do parâmetro
        String htmlValue = enviarEmail.getHtmlBody().replace('{CompanyName}', CompanyName);
            
        htmlValue = htmlValue.replace('{CNPJ}', CNPJ);
        htmlValue = htmlValue.replace('{InscricaoEM}', InscricaoEM);
        htmlValue = htmlValue.replace('{Phone}', Phone);
        htmlValue = htmlValue.replace('{lastname}', lastname);
        htmlValue = htmlValue.replace('{Endereco}', Endereco);
        htmlValue = htmlValue.replace('{CEP}', CEP);
        htmlValue = htmlValue.replace('{Numero}', Numero);
        htmlValue = htmlValue.replace('{Bairro}', Bairro);
        htmlValue = htmlValue.replace('{Cidade}', Cidade);
        htmlValue = htmlValue.replace('{Estado}', Estado);
        htmlValue = htmlValue.replace('{EnderecoEntrega}', EnderecoEntrega);
        htmlValue = htmlValue.replace('{CEPEntrega}', CEPEntrega);
        htmlValue = htmlValue.replace('{NumeroEntrega}', NumeroEntrega);
        htmlValue = htmlValue.replace('{BairroEntrega}', BairroEntrega);
        htmlValue = htmlValue.replace('{CidadeEntrega}', CidadeEntrega);
        htmlValue = htmlValue.replace('{EstadoEntrega}', EstadoEntrega);
        htmlValue = htmlValue.replace('{email}', email);           	
        
        // setando o html modificado para ser enviado no email
        enviarEmail.setHtmlBody(htmlValue);
    
        // ação de enviar o email setado anteriormente
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {enviarEmail});
    }
}