//
//  ContentView.swift
//  Aula04_AppCompras
//
//  Created by IOS SENAC on 21/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var mObjContext
    
    @FetchRequest(
        entity: Serie.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Serie.assistida, ascending: true)
        ]
    ) var series:FetchedResults<Serie>
    
    let db = Persistencia.db
    
    @State var txtNome:String = ""
    @State var assistida:Bool = false
    @State var tabAtual:String = "lista"
    
    var body: some View {

        TabView (selection: $tabAtual) {
            
            // Tab 1
            VStack (spacing: 20){
                
                Text("Cadastrar nova Série")
                
                TextField("Nome da Série", text: $txtNome )
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Toggle( isOn: $assistida ) {
                    Text("Assistida?")
                }
                
                Button("Salvar"){
                    
                    let novaSerie = Serie(context: mObjContext)
                    novaSerie.nome = txtNome
                    novaSerie.assistida = assistida
                    
                    db.salvar()
                    
                    txtNome = ""
                    tabAtual = "lista"
                    
                }
                .padding(.horizontal, 20.0)
                .padding(.vertical, 10.0)
                .background(Color.green)
                .accentColor(.white)
                .cornerRadius(5.0)
                
            }
            .padding()
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .top)
            .tabItem {
                Image(systemName: "square.and.pencil" )
                Text("Cadastrar")
            }
            .tag("formulario")
            
            
            // Tab 2
            VStack {
                
                Text("Séries Cadastradas")
                
                List {

                    ForEach( series, id: \.self ){ serie in

                        HStack {
                            
                            Text( serie.nome! )
                            
                            serieAssistida( serie.assistida )
                                
                            
                        }

                    }.onDelete( perform: remover )

                }
                
            }
            .tabItem {
                Image(systemName: "list.dash" )
                Text("Séries")
            }
            .tag("lista")
            
        }
        //.tabViewStyle(PageTabViewStyle())
        
    }
    
    func serieAssistida( _ assistida:Bool ) -> Text{
        
        let texto = assistida ? "Assistida" : "Não Assistida"
        let cor = assistida ? Color.green : Color.red
        
        return Text(texto).foregroundColor(cor)
        
    }
    
    func remover( at offset:IndexSet ){
        
        for index in offset {
            
            db.deletar(series[index])
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
