//
//  DetailPage.swift
//  Final
//
//  Created by Ablai Nuraliev on 12.05.2021.
//

import SwiftUI


struct DetailView: View {
    var exp_id: Int
    @State var exp: ExpDetail = ExpDetail()
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            VStack(alignment: .leading){
                ScrollView{
                    MainView(exp: exp)
                    ExpectView(exp: exp)
                    ////                    MarshrutView(exp: exp)
                    ImportantInformationView(exp: exp)
                    Host(exp: exp)
                    AdditionView(exp: exp)
                    ReviewView(exp_id: exp_id)
                }
            }
            
            
            VStack(alignment: .center){
                NavigationLink(destination: PickerView(exp: exp, exp_id: exp_id)) {
                    Text("Перейти к покупке")
                }
                .font(.title2)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                .cornerRadius(8)
            }
            .frame(width: UIScreen.main.bounds.width/1.25, height: UIScreen.main.bounds.height/15)
            .background(Color("Color"))
            
            .background(Color.white.opacity(1210).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
            .navigationBarHidden(true)
            
        }.onAppear(){
            apiCall().getExpDetail { (res) in
                self.exp = res
            }
        }
        
        
        
        
    }
}
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailView(exp_id: 3)
        
    }
}

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var exp: ExpDetail
    var body: some View{
        
        HStack{
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
            })
            Image("ex2").resizable().frame(width:130, height:30, alignment: .center)
                .padding(.leading, UIScreen.main.bounds.width/4)
        }
        .padding()
        .lineLimit(nil)
        .frame(width: UIScreen.main.bounds.size.width, height: 40, alignment: .leading)
        .border(Color.gray.opacity(0.5), width: 1)
        ImageViewDetail(withURL: exp.images?[0].image ?? "https://znaiwifi.com/wp-content/uploads/2018/01/hqdefault.jpg")
        
        VStack(alignment: .leading){
            
            Text(exp.title ?? "Загрузка...")
                .font(.title2)
                .padding(.top, 20.0)
            
            HStack(spacing: 4){
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Text(String(exp.average ?? 0))
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 5, height: 5)
                Text(String(exp.review_count ?? 0))
                
            }
            HStack{
                
                Text(exp.city ?? "Загрузка...")
                    .foregroundColor(Color.gray)
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.gray)
                Text(exp.category?.first_category ?? "Загрузка...")
                    .foregroundColor(Color.gray)
            }
            
            
            HStack{
                
                Text(String(exp.metric?.see ?? 0) + " просмторов")
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 5, height: 5)
                Text(String(exp.metric?.bought ?? 0) + " покупок")
            }
            
        }
        .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
        .padding(.leading, 30)
        Spacer()
        
    }
}

struct ExpectView: View{
    var exp: ExpDetail
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Что ожидать")
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(exp.features ?? []) { item in
                        VStack(alignment: .leading){
                            Image(systemName: "flame").resizable()
                                .padding(.all, 19.0)
                                .frame(width: 70, height: 70, alignment: .center)
                                .foregroundColor(.red)
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(10)
                            Text(item.title)
                        }
                    }
                    
                    
                    
                }
            }
            VStack(alignment: .leading){
                Text(exp.what_to_expect ?? "Loading...")
            }
            .padding(.all, 20.0)
            .frame(width: UIScreen.main.bounds.width/1.1, alignment: .topLeading)
            .background(Color.gray.edgesIgnoringSafeArea(.all).opacity(0.15))
            .cornerRadius(10)
        }
        .padding(.all, 30.0)
        
    }
}

//struct MarshrutView: View {
//    var exp: ExpDetail
//    var body: some View{
//        VStack(alignment: .leading){
//            Text("Маршрут")
//                .font(.title)
//
//            List(exp.points ?? []) { item in
//
//                HStack{
//                    Image(systemName: "circle").resizable()
//                        .frame(width: 10, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .background(Color.black)
//                    VStack(alignment: .leading){
//                        Text(item.venue_title )
//                        Text("Description")
//                    }
//                }
////                if(item<2){
////                    Rectangle()
////                        .fill(Color.black)
////                        .frame(width: 2, height: 40)
////                }
//
//
//            }
//        }
//        .padding(.leading, 20)
//        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
//    }
//}

struct ImportantInformationView: View {
    var exp: ExpDetail
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Важная информация").font(.title)
            VStack(alignment: .leading ,spacing: 20){
                HStack(alignment: .top){
                    Text("Огранечения:")
                        .fontWeight(.bold)
                    Text(exp.inclusions ?? "Загрузка...")
                }
                .padding(.top, 10)
                HStack{
                    Text("Продолжительность:")
                        .fontWeight(.bold)
                    Text(String(exp.durability ?? 0)+"часа")
                }
                HStack{
                    Text("Вместимость:")
                        .fontWeight(.bold)
                    Text(String(exp.capacity ?? 0)+" человек")
                }
                VStack(alignment: .leading){
                    Text("Что взять собой")
                        .fontWeight(.bold)
                    Text(String(exp.client_demands ?? "Loading"))
                }
                VStack(alignment: .leading){
                    Text("Что включено")
                        .fontWeight(.bold)
                    Text(String(exp.inclusions ?? "Loading"))
                }
                VStack(alignment: .leading){
                    Text("Что не включено")
                        .fontWeight(.bold)
                    Text(String(exp.exclusions ?? "Loading"))
                }
            }
        }
        .padding(.top, 20)
        .padding(.leading, 20)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct Host: View {
    var exp: ExpDetail
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Организатор").font(.title)
            VStack(alignment: .leading){
                HStack(alignment: .top, spacing: 20){
                    Image(systemName: "person").resizable()
                        .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .cornerRadius(50)
                    VStack(alignment: .leading, spacing: 3){
                        Text(exp.host?.title ?? "Loading")
                        HStack{
                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(.white)
                                    .background(Color.yellow)
                                    .padding(.all, 5)
                                Text(String(exp.host?.review_count ?? 0)+" отзывов")
                            }
                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(.white)
                                    .background(Color.yellow)
                                    .padding(.all, 5)
                                Text(String(exp.host?.experience_count ?? 0)+" впечетления")
                            }
                        }
                        Text(exp.host?.phone ?? "Нету")
                    }
                }
                VStack{
                    Text(exp.host?.bio ?? "Loading...")
                    
                }
                .padding(.all, 10)
            }
            .padding(.top, 20)
            .padding(.all, 10)
            .background(Color.blue.opacity(0.09))
            .cornerRadius(10)
            
            
        }
        .padding([.leading, .top], 10)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct AdditionView: View{
    var exp: ExpDetail
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20){
            Text("Дополнительно").font(.title)
            VStack(alignment: .leading, spacing: 10){
                Text("Правила отмены и возврата")
                    .fontWeight(.bold)
                Text(exp.refund_policy ?? "Loading..")
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Другие советы")
                    .fontWeight(.bold)
                Text(exp.other_info ?? "Loading...  ")
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Требование к гостю")
                    .fontWeight(.bold)
                Text(exp.client_demands ?? "Loading...  ")
            }
        }
        .padding(.leading)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct ReviewView: View {
    var exp_id: Int
    @State var review_list: [Review] = [Review]()
    @State private var showingSheet = false
    
    var body: some View{
        VStack(alignment: .leading){    
            HStack{
                Text("Отзывы")
                    .font(.title)
                Spacer()
                Button("Написать"){
                    showingSheet.toggle()
                    
                }
                .sheet(isPresented: $showingSheet) {
                    WriteReview(review_list: $review_list, exp_id: exp_id)
                }
                .font(.title2)
                .padding([.leading, .trailing], 10)
                .frame( height: 50, alignment: .center)
                .border(Color.black, width: 2)
                .foregroundColor(.black)

                
            }
            .padding(.trailing, 20)
            
            
            VStack(alignment: .leading, spacing: 30){
                
                ForEach(review_list){ item in
                    HStack(alignment: .top){
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "person")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                Text(item.user.first_name).font(.title2)
                                Text(item.user.last_name).font(.title2)
                                
                                
                            }
                            HStack{
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Text(item.created_at)
                            }
                            Text(item.text)
                                .padding(.top, 10)
                            
                        }
                    }
                    
                    Divider()
                    
                    
                }
                
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
        .onAppear(){
            apiCall().getReviews(exp: exp_id) { (res) in
                self.review_list = res
            }
        }
    }
}



struct ImageViewDetail: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    
    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        
        Image(uiImage: image)
            .resizable()
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/4, alignment: .center)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}
