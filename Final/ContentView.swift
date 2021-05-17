//
//  ContentView.swift
//  Final
//
//  Created by Ablai Nuraliev on 11.05.2021.
//

import SwiftUI
import Combine
struct ContentView: View {
    @State var exp_list: [Experience] = [Experience]()
    @State var cat_list: [ExperienceCategories] = [ExperienceCategories]()
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                HeadView()
                CategoriesView(catss: cat_list)
                HStack{
                    Text("3")
                    Text("впечетление найдено")
                    Image(systemName: "xmark")
                        .frame(width: UIScreen.main.bounds.size.width/2.5, alignment: .trailing)
                    
                }
                .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
                .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
                .background(Color.black.opacity(0.05))
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(exp_list) { item in
                            CardView(exp: item)
                        }
                    }
                }
                
                
                Spacer()
                
            }
            
            .navigationBarHidden(true)
        }.onAppear(){
            apiCall().getFilterPage { (res) in
                self.exp_list = res
            }
            
            apiCall().getCategories{ (response) in
                self.cat_list = response
                
            }
        }
        
    }
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CategoriesView: View{
    @State private var clicked = false
    var catss: [ExperienceCategories] = [ExperienceCategories]()
    var body: some View{
        VStack(){
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(catss) { item in
                        Button(String(item.title))
                        {
                            clicked = true
                        }
                        .padding(/*@START_MENU_TOKEN@*/.all, 8.0/*@END_MENU_TOKEN@*/)
                        
                        .background(Color.white)
                        .border(Color.gray.opacity(0.5), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)                        .cornerRadius(2)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)                        
                    }
                    .padding(10.0)
                }
                .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
            }
            
        }
    }
}

struct HeadView: View{
    var body: some View{
        HStack{
            Group{
                Button(action: {
                    print("Edit button was tapped")
                }) {
                    Image(systemName: "magnifyingglass")
                        .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    
                }
                Button(action: {
                    print("Edit button was tapped")
                }) {
                    Image(systemName: "line.horizontal.3")
                        .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    
                }
            }
            .frame(width: 70.0, height: 47.0)
        }
        .frame(width: UIScreen.main.bounds.size.width, alignment: .topTrailing)
        .border(Color.gray.opacity(0.5), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        
    }
}

struct CardView: View{
    var exp: Experience
    var body: some View {
        
        HStack(alignment: .top){
            ImageView(withURL: String(exp.image.image ?? "https://images.squarespace-cdn.com/content/v1/5cfeddc54a957c0001a516a1/1601558187238-9E1TVXH5Y0J1Q1S5LUTV/ke17ZwdGBToddI8pDm48kMTQhbj3w58aLNpPkmirYI8UqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYy7Mythp_T-mtop-vrsUOmeInPi9iDjx9w8K4ZfjXt2djwo1EYuBQVXLulF0qa4lbhmDj7Zv_Z3SgjzHV8SRhuACjLISwBs8eEdxAxTptZAUg/Screen+Shot+2020-10-01+at+9.16.08+AM.png?format=1000w"))
                .frame(width: UIScreen.main.bounds.size.width/3.5, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading, spacing: 5){
                HStack{
                    Text((exp.content_type == 0) ? "MEETUP" : "VIBE")
                    Text("-")
                    Text((exp.format_type == 0) ? "ONLINE" : "OFFLINE")
                    
                }
                NavigationLink(destination: DetailView(exp_id: exp.id)) {
                    Text(exp.title)
                        .foregroundColor(.black)
                }
                HStack(spacing: 4){
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Text(String(exp.average))
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 5, height: 5)
                    Text(String(exp.review_count))
                    
                }
                HStack{
                    Image(systemName: "person.2.fill")
                    Text(exp.host.title)
                }
                HStack(spacing: 80){
                    Text("от " + String(exp.min_price)+" Т")
                    Text(String(exp.metric.bought)+" купили")
                        .padding(.all, 5.0)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(8)
                    
                }
                
                
                
            }
            .frame(width: UIScreen.main.bounds.size.width/1.6,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
        .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
    }
}



// MARK: - Experiences



class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}


struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    
    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:100, height:100)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}
