public with sharing class ToDoListConfig {

    @AuraEnabled(cacheable = true)
    public static List<ToDoList__c> getTarefas() {
        return [SELECT Id, Name, Concluido__c FROM ToDoList__c];
    }
    
    @AuraEnabled(cacheable = true)
    public static Integer getQuantidadeNaoConcluido() {
        return [SELECT COUNT() FROM ToDoList__c WHERE Concluido__c = FALSE];
    }

    @AuraEnabled
    public static void criarTarefa(String NomeTarefas) {
        List<ToDoList__c> todasTarefas = [SELECT Id, Name, Concluido__c FROM ToDoList__c WHERE Name =: NomeTarefas];
        
        ToDoList__c listTarefa = new ToDoList__c();
        listTarefa.Name = NomeTarefas;
        
        if(todasTarefas.isEmpty()) {
            insert listTarefa;
        }
    }

    @AuraEnabled
    public static void atualizarTarefa(String NomeTarefas, String Id) {
        List<ToDoList__c> tarefas = [SELECT Id, Name, Concluido__c FROM ToDoList__c WHERE Id =: Id];
        
        for(ToDoList__c tarefa : tarefas) {
            tarefa.Name = NomeTarefas; 
        }
        
        if(!tarefas.isEmpty()) {
            update tarefas;
        }
    }

    @AuraEnabled
    public static void deleteTarefa(String id) {
        List<ToDoList__c> IdsTarefas = [SELECT Id FROM ToDoList__c WHERE Id =: id];

        try {
            if(!IdsTarefas.isEmpty()) {
                delete IdsTarefas;
            }

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void atualizarConcluido(String id) {
        List<ToDoList__c> tarefas = [SELECT Id, Name, Concluido__c FROM ToDoList__c WHERE Id =: id];

        for(ToDoList__c tarefa : tarefas) {
            tarefa.Concluido__c = !tarefa.Concluido__c; 
        }

        try {
            if(!tarefas.isEmpty()) {
     
                update tarefas;
            }

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
