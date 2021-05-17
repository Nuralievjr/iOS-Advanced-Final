//
//  pre-checkout.swift
//  Final
//
//  Created by Ablai Nuraliev on 12.05.2021.
//

import SwiftUI

struct pre_checkout: View {
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                HeaderView()
                ChooseView()
                OrderDescription()
                Spacer()
            }
            
            VStack(alignment: .center){
                Button("Оплатить")
                {
                    
                }
                .font(.title2)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                .cornerRadius(8)
            }
            .frame(width: UIScreen.main.bounds.width/1.25, height: UIScreen.main.bounds.height/15)
            .background(Color.red)
            .cornerRadius(8)
            .navigationBarHidden(true)

        }
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct pre_checkout_Previews: PreviewProvider {
    static var previews: some View {
        pre_checkout()
    }
}

struct ChooseView: View {
    var body: some View{
        VStack(alignment: .leading){
            Text("Способ оплаты").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            HStack{
                RadioButton(ifVariable: true, onTapToActive: {
                    
                }, onTapToInactive: {
                    
                })
                Image(systemName: "creditcard.fill")
                    .resizable().frame(width: 30, height: 20)
                    .foregroundColor(.yellow)
                Text("Банковской картой").font(.title2).fontWeight(.semibold)
            }
            HStack{
                RadioButton(ifVariable: false, onTapToActive: {
                    
                }, onTapToInactive: {
                    
                })
                Image(systemName: "creditcard.fill")
                    .resizable().frame(width: 30, height: 20)
                    .foregroundColor(.green)
                Text("Homebank")
                    .font(.title2).fontWeight(.semibold)
            }
            Divider()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)

    }
}

struct OrderDescription:View {
    var body: some View{
        VStack(alignment: .leading, spacing: 8){
            Text("Тур на пик фурманова").font(.title2)
            
            HStack{
                HStack{
                    Image(systemName: "eye.fill")
                        .foregroundColor(.green)
                    Text("140 просмторов")
                }
                .foregroundColor(.gray)
                HStack{
                    Image(systemName: "cart.fill")
                        .foregroundColor(.green)
                    Text("530+ купили")
                }
                .foregroundColor(.gray)
            }
         
            Text("Нуралиев Абылай")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Divider()
            
            VStack(alignment: .trailing){
                HStack{
                    Text("Итог")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("10 000 Т")
                        .fontWeight(.semibold)
                }
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}
