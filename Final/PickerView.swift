//
//  PickerView.swift
//  Final
//
//  Created by Ablai Nuraliev on 12.05.2021.
//

import SwiftUI

struct PickerView: View {
    @State private var isPresented = false
    var exp: ExpDetail
    var exp_id: Int
    @State var adult_x = 1
    @State var teen_x = 0
    @State var child_x = 0
    @State var day: Int = 0
    @State var options: [Option] = [Option]()
    var body: some View {
        ZStack{
        ZStack(alignment: .bottom){
            VStack(alignment: .leading){
                HeaderView()
                AddInfo()
                SelectionView(isPresented: $isPresented)
                OptionsView(opt: options)
                Spacer()
                
            }
            .onAppear(){
                print(day)
                
                if(day != 0){
                    if((exp.dates?.days) != nil){
                        day = exp.dates?.days?[0].id ?? 0
                        print("LL", day)
                        
                    }
                }
                apiCall().GetOption(day: 2, experience: exp_id, adult: adult_x, teen: teen_x, child: child_x) { (res) in
                    options = res
                }
            }
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            .blur(radius: isPresented ? 4 : 0)
            
            Spacer()
            
            VStack(alignment: .center){

                NavigationLink(destination: pre_checkout()) {
                    Text("Перейти к покупке")
                }
                .font(.title2)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                .cornerRadius(8)
                .padding(.all, 20.0)
                .font(.title2)
                .foregroundColor(.white)
            }
            .frame(width: UIScreen.main.bounds.width/1.25, height: UIScreen.main.bounds.height/15)
            .background(Color("Color"))
            .cornerRadius(8)
            .blur(radius: isPresented ? 4 : 0)

            
            
            
        }
        
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .navigationBarHidden(true)
        
        
            if(isPresented==true){
                PeoplePickerView(isPresented: $isPresented, adult_x: $adult_x, teen_x: $teen_x, child_x: $child_x)
            }
            
        
        }
    }
}

//struct PickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerView(exp_id: 3)
//    }
//}

struct HeaderView: View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                    
                })
                Image("ex2").resizable().frame(width:130, height:30, alignment: .leading)
                    .padding(.leading, UIScreen.main.bounds.width/4)
            }
            
        }
        .padding()
        .lineLimit(nil)
        .frame(width: UIScreen.main.bounds.size.width, height: 40, alignment: .leading)
        .border(Color.gray.opacity(0.5), width: 1)
        //        .padding([.leading, .bottom, .trailing], 20)
        
    }
}

struct AddInfo: View{
    var body: some View{
        HStack(alignment: .top){
            VStack(alignment: .leading){
                Text("от 2500 Т").font(.title2)
                
                Text("За 1 человека")
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            Spacer()
            HStack{
                HStack{
                    Image(systemName: "eye")
                    Text("1410")
                }
                HStack{
                    Image(systemName: "person")
                    Text("151")
                }
            }
            .padding(.all, 10)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(8)
        }
        .padding(.all, 20)
        
        Text("Lorem ipsum lorem ipsum lorem ipsum")
            .padding(.all, 20)
        
    }
}

struct SelectionView: View {
    @State private var date = Date()
    @Binding var isPresented: Bool
    var body: some View{
        
        ZStack{
            VStack{
                HStack(alignment: .center){
                    DatePicker(
                        "Дата",
                        selection: $date,
                        displayedComponents: [.date]
                        
                    )
                    
                }
                .padding([.all], 20)
                .border(Color.gray.opacity(0.5), width: 1)
                .cornerRadius(4)
                .frame(width: UIScreen.main.bounds.width/1.1, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding([.leading, .bottom, .trailing], 20)
                
                HStack {
                    Text("Гостей")
                        .padding(.leading, 20)
                    Spacer()
                    Button("1 гость"){
                        isPresented.toggle()
                    }
                    
                }
                .padding([.trailing,.top, .bottom], 30)
                .border(Color.gray.opacity(0.5), width: 1)
                .cornerRadius(4)
                .frame(width: UIScreen.main.bounds.width/1.1, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding([.leading, .bottom, .trailing], 20)
            }
            
        }
        
        
    }
}

struct PeoplePickerView: View{
    @Binding var isPresented: Bool
    @Binding var adult_x: Int
    @Binding var teen_x: Int
    @Binding var child_x:Int
    
    
    var body: some View{
        VStack(alignment: .center){
            VStack(spacing: 20){
                HStack{
                    Text("Взрослый").font(.title3).foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 20){
                        Button("+"){
                            adult_x = adult_x+1
                        }
                        .foregroundColor(.white)
                        .font(.title)
                        .padding([.top, .bottom], 3)
                        .padding([.leading, .trailing],10)
                        .background(Color("Color"))
                        .cornerRadius(6)
                        Text("\(self.adult_x)")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        
                        Button("-"){
                            if(adult_x != 0){
                                adult_x = adult_x-1
                            }
                            
                        }
                        .font(.title)
                        .foregroundColor(.white)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding([.top, .bottom], 3)
                        .padding([.leading, .trailing],10)
                        .background(Color.gray)
                        .cornerRadius(6)
                        
                    }
                    
                    
                }
                .padding()
                
                
                
                
                HStack{
                    Text("Подросток").font(.title3).foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 20){
                        Button("+"){
                            teen_x = teen_x + 1
                        }
                        .foregroundColor(.white)
                        .font(.title)
                        .padding([.top, .bottom], 3)
                        .padding([.leading, .trailing],10)
                        .background(Color("Color"))
                        .cornerRadius(6)
                        Text("\(self.teen_x)")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        
                        Button("-"){
                            if(teen_x != 0){
                                teen_x = teen_x - 1
                            }
                        }
                        .font(.title)
                        .foregroundColor(.white)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding([.top, .bottom], 3)
                        .padding([.leading, .trailing],10)
                        .background(Color.gray)
                        .cornerRadius(6)
                        
                    }
                    
                    
                }
                .padding()
                
                
                HStack{
                    Text("Детский").font(.title3).foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 20){
                        Button("+"){
                            child_x = child_x + 1
                        }
                        .foregroundColor(.white)
                        .font(.title)
                        .padding([.top, .bottom], 3)
                        .padding([.leading, .trailing],10)
                        .background(Color("Color"))
                        .cornerRadius(6)
                        Text("\(self.child_x)")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        
                        Button("-"){
                            if(child_x != 0){
                                child_x = child_x - 1
                            }
                        }
                        .font(.title)
                        .foregroundColor(.white)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding([.top, .bottom], 3)
                        .padding([.leading, .trailing],10)
                        .background(Color.gray)
                        .cornerRadius(6)
                        
                    }
                    
                    
                }
                .padding()
            }
            .padding(.trailing, 10)
            .padding(.top, 60)
            
            Button("Сохранить"){
                isPresented.toggle()
            }
            .padding()
            .background(Color("Color"))
            .cornerRadius(8)
            .foregroundColor(.white)
            Spacer()
            
        }
        .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.gray.opacity(0.8))
        .cornerRadius(20)
        
    }
}


struct OptionsView: View{
    var opt: [Option]
    @State var total_sum: Int = 0
    @State var choose: Bool = false
    @State var selectedId: String = ""

    var body: some View{
        ZStack(alignment: .bottom){
            VStack{
                VStack{
                    HStack(alignment: .top){
                        Text("Итог \(total_sum) Т")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                    }
                    .padding(.trailing, 20)
                    .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
                    
//                    VStack(alignment: .trailing){
//                        Text("взр. 1 x 2500 Т")
//                        Text("подр. 1 x 2500 Т")
//                        Text("дет. 1 x 2500 Т")
//                    }
//                    .foregroundColor(.gray)
//                    .padding(.trailing, 20)
//                    .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
                }
                ForEach(opt){item in
                    VStack(alignment: .leading){
                        HStack(alignment: .top){
                            RadioButton(ifVariable: choose, onTapToActive: {
                                choose = true
                                total_sum = item.total?.sum ?? 0
                                
                            }, onTapToInactive: {
                                choose = false

                            })
                            .padding(.top, 5)
                            VStack(alignment: .leading){
                                Text(item.title ?? "Loading").font(.title3)
                                Text(String(item.total?.adult_price?.price ?? 0)+" с человека").font(.title3).fontWeight(.bold)
                                    .padding(.top, 5)
                                
                            }
                            
                        }
                        Divider()
                        
                    }
                    .padding([.leading, .top, .trailing], 20)
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                }
                
                
                
                
            }
        }
    }
}

struct RadioButton: View {
    let ifVariable: Bool
    let onTapToActive: ()-> Void
    let onTapToInactive: ()-> Void
    
    var body: some View {
        Group{
            if ifVariable {
                ZStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                }.onTapGesture {self.onTapToInactive()}
            } else {
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .onTapGesture {self.onTapToActive()}
            }
        }
    }
}
