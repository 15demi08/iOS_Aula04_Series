//
//  PersistenceController.swift
//  Aula04_AppCompras
//
//  Created by IOS SENAC on 21/08/21.
//

import CoreData

struct Persistencia {
    
    static let db = Persistencia()
    
    let container:NSPersistentContainer
    
    init(){
        
        container = NSPersistentContainer(name: "modeloDados")
        container.loadPersistentStores{ (decricao, erro) in
            if let erro = erro {
                fatalError("Erro: \(erro.localizedDescription)")
            }
        }
        
    }
    
    func salvar( callback: @escaping (Error?) -> () = {_ in} ){
        
        let contexto = container.viewContext
        
        if contexto.hasChanges {
            
            do {
                try contexto.save()
                callback(nil)
            } catch {
                callback(error)
            }
            
        }
            
    }
    
    func deletar( _ objeto:NSManagedObject, callback: @escaping (Error?) -> () = {_ in} ){
        
        let contexto = container.viewContext
        
        contexto.delete(objeto)
        
        salvar(callback: callback)
        
    }
    
}
