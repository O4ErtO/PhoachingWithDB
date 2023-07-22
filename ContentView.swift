//
//  ContentView.swift
//  PhoachingWithDB
//
//  Created by Artem Vekshin on 14.07.2023.
//


import SwiftUI
struct FontsHeadlins24px: View {
var headline: String
    var body: some View {
        Text(headline)
            .fontWeight(.medium)
            .font(Font.custom("Unbounded-VariableFont_wght.ttf", size: 24))
            
    }
}
struct FontsBody16px: View {
var bodyfont: String
    var body: some View {
        Text(bodyfont)
            .foregroundColor(Color(red: 0.31, green: 0.36, blue: 0.39))
        

            .fontWeight(.light)
            .font(Font.custom("NunitoSans-VariableFont_YTLC,opsz,wdth,wght.ttf", size: 16))
            
    }
}


struct ContentView: View {
    @State private var showingAlert = false
    @State var PhoacAuthor = [PhoachresultsForAuthorElement]()
    @State var PhoacMy = [PhoachresultsForMyElement]()
    @State private var selectedPhoach = 0
    let titles:[String] = ["Мои", "Авторские"]
    
    
    
    var body: some View {
        VStack {
           
            SegmentedControlView(selectedIndex: $selectedPhoach, titles: titles)
                .navigationViewStyle(StackNavigationViewStyle())
                .font(Font.custom("Helvetica", size: 24))
                .fixedSize()
            Spacer()
            if  selectedPhoach == 0{
                NavigationView{
                    
                    List(PhoacMy, id: \.id){ PhoacMy in
                        VStack(alignment: .leading,spacing: 8){
                            FontsHeadlins24px(headline: PhoacMy.title)
                            FontsBody16px(bodyfont: PhoacMy.author)
                                

                                
                        } .swipeActions(allowsFullSwipe: false){
                            Button{
                                print("edit")
                            }label: {
                                Label("", image: "highlight")
                                    .tint(Color(red: 0.1, green: 0.57, blue: 0.7))
                            }
                            Button{
                                print("listed!")
                            }label: {
                                Label("", image: "checklist")
                                
                                    .tint(Color(red: 0.28, green: 0.65, blue: 0.8))
                                
                            }
                            Button{
                                print("copied!")
                            }label: {
                                Label("", image: "copy")
                                    .tint(Color(red: 0.55, green: 0.78, blue: 0.87))
                            }
                            Button{
                                print("sharing")
                            }label: {
                                Label("", image: "share")
                                    .tint(Color(red: 0.85, green: 0.85, blue: 0.85))
                            }
                            
                            Button{
                                showingAlert = true
                            }
                            
                        label: {
                            Label("", image: "delete 2")
                                .tint(Color(red: 0.98, green: 0.59, blue: 0.64))
                            
                        }
                        }.alert(isPresented:$showingAlert) {
                            Alert(
                                title: Text("Удалить фоучинг?"),
                                primaryButton: .destructive(Text("Удалить")) {
                                    
                                },
                                secondaryButton: .cancel(Text("Отмена"))
                            )}
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity) // Растянуть по всей ширине и высоте
                        .listStyle(PlainListStyle()) // Установить стиль списка
                    
                    
                }.onAppear(){
                    MyphoachServer.shared.sendRequestWithAuthorization { phoachDataforme in
                        if let phoachDataforme = phoachDataforme{
                            PhoacMy = phoachDataforme
                            
                        }
                        else{
                            print("Не удалось получить данные")
                        }
                    }
                }
            }else{
                NavigationView{
                    List(PhoacAuthor, id: \.id){ PhoacAuthor in
                        VStack(alignment: .leading,spacing: 8){
                            FontsHeadlins24px(headline: PhoacAuthor.title)
                            FontsBody16px(bodyfont: PhoacAuthor.author)}
                        .swipeActions(allowsFullSwipe: false){
                            Button{
                                showingAlert = true
                                
                            }label: {
                                Label("", image: "delete 2")
                                    .tint(Color(red: 0.98, green: 0.59, blue: 0.64))
                            }
                        }
                    }.alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("Удалить фоучинг?"),
                            primaryButton: .destructive(Text("Удалить")) {
                                print("Deleting...")
                            },
                            secondaryButton: .cancel(Text("Отмена"))
                        )}
                }.frame(maxWidth: .infinity, maxHeight: .infinity) // Растянуть по всей ширине и высоте
                    .listStyle(PlainListStyle())
                    .onAppear(){
                        AuthorphoachServer.shared.sendRequestWithAuthorization(){ phoachDataAuth in
                            if let phoachDataAuth = phoachDataAuth{
                                PhoacAuthor = phoachDataAuth
                            }else{
                                print("Wrong Author data")
                            }
                            
                        }
                    }
                
                Spacer()
            }
            
        }
    }
    
}






#Preview {
    ContentView()
}
