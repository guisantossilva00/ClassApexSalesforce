public with sharing class RenovarOportunidade {
    @InvocableMethod
    public static void CriarRenovacaoOportunidade(List<Id> id) {
        Opportunity getOportunidades = [
            SELECT Id, IsDeleted, AccountId, IsPrivate, Name, Description, StageName, Amount, Probability, ExpectedRevenue, TotalOpportunityQuantity, CloseDate, Type, NextStep, LeadSource, IsClosed, IsWon, ForecastCategory, ForecastCategoryName, CampaignId, HasOpportunityLineItem, Pricebook2Id, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, PushCount, LastStageChangeDate, FiscalQuarter, FiscalYear, Fiscal, ContactId, LastViewedDate, LastReferencedDate, SyncedQuoteId, HasOpenActivity, HasOverdueTask, LastAmountChangedHistoryId, LastCloseDateChangedHistoryId, DeliveryInstallationStatus__c, TrackingNumber__c, OrderNumber__c, CurrentGenerators__c, MainCompetitors__c, QuantidadeMes__c, Prevenda__c, TipoOportunidade__c, ExecutivoDelivery__c, Contato__c, DataAbertura__c, Sequencia__c, MotivoFechamento__c, ModeloDelivery__c, campanha__c, Gatilho__c, Oferta__c, For__c, ID__c, OportunidadePai__c, ExecutivoContas__c, Orcamento__c, ValorEestimado__c, Tecnologia__c, Oportunidade__c, ValorMensal__c, ModeloComercial__c, Data_entrega_proposta__c
            FROM Opportunity
            WHERE Id IN: id
        ];

        Opportunity RenovacaoOportunidade = new Opportunity();

        RenovacaoOportunidade = getOportunidades.clone(false, true, false, false);
        RenovacaoOportunidade.TipoOportunidade__c = 'Renovação';
        RenovacaoOportunidade.Sequencia__c += 1;
        RenovacaoOportunidade.OportunidadePai__c = getOportunidades.Id;
        RenovacaoOportunidade.StageName = 'Prospecting';
        
        insert RenovacaoOportunidade;
    }
}
