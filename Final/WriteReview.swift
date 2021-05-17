//
//  WriteReview.swift
//  Final
//
//  Created by Ablai Nuraliev on 16.05.2021.
//

import SwiftUI

struct WriteReview: View {
    @Environment(\.presentationMode) var presentationMode

    @State var text_rev: String = ""
    @Binding var review_list: [Review]
     var exp_id: Int
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Text("Написать отзыв")
                .font(.title)
            Divider()

            Divider()

            TextField("Написать...", text: $text_rev)
                .padding()
                .frame(height: UIScreen.main.bounds.height/3, alignment: .top)
            Divider()

            Spacer()

            Button(action: {
                if(text_rev != ""){
                    apiCall().addReview(exp: exp_id, text: text_rev, vote: 5) { res in
                        review_list.append(res)
                    }
                    
                    presentationMode.wrappedValue.dismiss()
                    
                }
                

            }, label: {
                Text("Опубликовать")
            })
            .padding()
            .frame(width: UIScreen.main.bounds.width/2,  alignment: .center)
            .background(Color.yellow)
            .foregroundColor(.white)
            
        }
    }
}

//struct WriteReview_Previews: PreviewProvider {
//    static var previews: some View {
//        WriteReview(review_list: [], exp_id: 3)
//    }
//}

