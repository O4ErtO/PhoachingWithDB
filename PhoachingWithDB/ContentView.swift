//
//  ContentView.swift
//  PhoachingWithDB
//
//  Created by Artem Vekshin on 14.07.2023.
//


import SwiftUI

struct ContentView: View {
    @State var PhoacAuthor = [PhoachresultsForAuthorElement]()
    @State var PhoacMy = [PhoachresultsForMyElement]()
    @State var selectedPhoach = 0
    let titles:[String] = ["Мои", "Авторсие"]
  
    
    
    var body: some View {
        VStack {
             
            SegmentedControlView(selectedIndex: $selectedPhoach, titles: titles)
                .navigationViewStyle(StackNavigationViewStyle())
            if  selectedPhoach == 0{
                NavigationView{
                    
                    List(PhoacMy, id: \.id){ PhoacMy in
                        VStack(alignment: .leading,spacing: 8){
                            Text(PhoacMy.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(Font.custom("Helevetica", size: 24))
                            Text(PhoacMy.author)
                                .tint(.gray)
                                .fontWeight(.light)
                                .font(Font.custom("Helvetica", size: 16))
                        }
                        
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
                        VStack(alignment: .leading,spacing: 24){
                            Text(PhoacAuthor.title)
                                .fontWeight(.bold)
                                .font(Font.custom("Helvetica", size: 24))
                            Text(PhoacAuthor.author)
                                    .tint(.gray)
                                    .fontWeight(.light)
                                    .font(Font.custom("Helvetica", size: 16))
                        }
                    }
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
            }
        }
    }
}






#Preview {
    ContentView()
}
