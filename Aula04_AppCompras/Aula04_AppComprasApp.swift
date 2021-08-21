//
//  Aula04_AppComprasApp.swift
//  Aula04_AppCompras
//
//  Created by IOS SENAC on 21/08/21.
//

import SwiftUI

@main
struct Aula04_AppComprasApp: App {
    
    let persistencia = Persistencia.db
    
    @Environment(\.scenePhase) var cena
    
    var body: some Scene {
        
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistencia.container.viewContext)
        }
        .onChange(of: cena){ novaCena in
            
            switch novaCena {
            
                case .background:
                    persistencia.salvar()
                case .inactive:
                    print("Inativa")
                case .active:
                    print("Ativa")
                @unknown default:
                    print("Padrão")
                    
            }
            
            
            
        }
        
    }
    
}
