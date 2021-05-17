//
//  ApiCall.swift
//  Final
//
//  Created by Ablai Nuraliev on 16.05.2021.
//

import Foundation

class apiCall {
    
    func getReviews(exp: Int ,completion:@escaping ([Review]) -> ()) {
        guard let url = URL(string: "https://www.vibes.kz/exp/api/reviews/\(exp)/") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let data = try! JSONDecoder().decode([Review].self, from: data!)
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        .resume()
    }
    func addReview(exp: Int, text: String, vote: Int, completion:@escaping (Review) -> ()){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: "https://www.vibes.kz/exp/api/experiences/reviews/add/")
        else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("jwt eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VybmFtZSI6ImFkbWluQGdtYWlsLmNvbSIsImV4cCI6MTYyMzc2OTUyMSwiZW1haWwiOiJhZG1pbkBnbWFpbC5jb20iLCJvcmlnX2lhdCI6MTYyMTE3NzUyMX0.zTwV9sGn_g_z_0-B86OAA8XIgyfTXPmzssIpy-T4w8Q", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        struct UploadData: Codable {
            let experience: Int
            let text: String
            let vote: Int
        }
        let uploadDataModel = UploadData(experience: exp, text: text, vote: 5)
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                    print("Error: Trying to convert model to JSON data")
                    return
                }
        request.httpBody = jsonData
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {return}

                    do{
                        let item = try JSONDecoder().decode(Review.self, from: data)
                        DispatchQueue.main.async {
                            completion(item)
                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
           
            
        }
        task.resume()
    }
    func getFilterPage(completion:@escaping ([Experience]) -> ()) {
        guard let url = URL(string: "https://www.vibes.kz/exp/api/experiences/") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let experriences = try! JSONDecoder().decode([Experience].self, from: data!)
            
            DispatchQueue.main.async {
                completion(experriences)
            }
        }
        .resume()
    }
    
    func getCategories(completion:@escaping ([ExperienceCategories]) -> ()) {
        guard let url = URL(string: "https://www.vibes.kz/venue/api/categories/1/") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let cats = try! JSONDecoder().decode([ExperienceCategories].self, from: data!)
            
            DispatchQueue.main.async {
                completion(cats)
            }
        }
        .resume()
    }
    
    func getExpDetail(completion:@escaping (ExpDetail) -> ()) {
        guard let url = URL(string: "https://www.vibes.kz/exp/api/detail/3/") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let data = try! JSONDecoder().decode(ExpDetail.self, from: data!)
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        .resume()
    }
    
    func GetOption(day: Int, experience: Int, adult: Int, teen: Int, child: Int, completion:@escaping ([Option]) -> ()){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: "https://www.vibes.kz/exp/api/options/")
        else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
                
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        struct OptionData: Codable {
            let experience: Int
            let day: Int
            let adult: Int
            let teen: Int
            let child: Int

        }
        let uploadDataModel = OptionData(experience: experience, day: day, adult: adult, teen: teen, child: child)
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                    print("Error: Trying to convert model to JSON data")
                    return
                }
        request.httpBody = jsonData
        let task = session.dataTask(with: request) { data, response, error in

            guard let data = data else {return}

                    do{
                        let decoder = JSONDecoder()
                        do {
                            let opt_data = try decoder.decode(OptionDataJson.self, from: data)
                            
                            DispatchQueue.main.async {
                                completion(opt_data.options ?? [])
                            }
                        }

                        
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
           
            
        }
        task.resume()
    }
    
    
}


struct AdultPrice: Codable
{
    var id: Int?
    var adult_x: Int?
    var price: Int?
}

struct TeenPrice: Codable
{
    var id: Int?
    var teen_x: Int?
    var price: Int?
}
struct ChildPrice: Codable
{
    var id: Int?
    var child_x: Int?
    var price: Int?
}
struct Total: Codable{
    var adult_price: AdultPrice?
    var teen_price: TeenPrice?
    var child_price: ChildPrice?
    var sum: Int?
}

struct Option: Codable, Identifiable{
    var id: Int?
    var isFree: Bool?
    var title: String?
    var subtitle: String?
    var total: Total?
    
}
struct OptionDataJson: Codable {
    var options: [Option]?
}


struct Rating: Decodable{
    var id: Int
    var created_at: String?
    var vote: Int
    var experience: Int
    var user: Int
}

struct User: Decodable {
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
}

struct Review: Decodable, Identifiable {
    var id: Int?
    var text: String
    var rating: Rating
    var user: User
    var created_at: String
    
}

struct Feature: Decodable, Identifiable {
    var id: Int
    var title: String
    var classname: String
}

//struct Points: Decodable, Identifiable{
//    var venue: Int
//    var venue_title: String
//    var experience: Int
//    var priority: Int
//    var add_info: String
//}
struct Rest_type: Decodable {
    var title: String
}

struct Language: Decodable {
    var id: Int
    var title: String
}


struct Day: Decodable {
    var id: Int?
    var date: String?
}
struct Days: Decodable {
    var days: [Day]?
}
struct hostDetail: Decodable {
    var id: Int
    var type: Int
    var title: String
    var phone: String?
    var review_count: Int?
    var experience_count: Int?
    var bio: String
    
}

struct ExpDetail: Decodable {
    var id: Int?
    var type: Int?
    var host: hostDetail?
    var images: [ImageObj]?
    var title: String?
    var average: Float?
    var review_count: Int?
    var city: String?
    var category: ExpCat?
    var features: [Feature]?
    var what_to_expect: String?
    //    var points: [Points]?
    var restriction_type: [Rest_type]?
    var durability: Int?
    var capacity: Int?
    var language: [Language]?
    var client_features: String?
    var inclusions: String?
    var exclusions: String?
    var refund_policy: String?
    var other_info: String?
    var client_demands: String?
    var dates: Days?
    var min_price: Float?
    var content_type: Int?
    var format_type: Int?
    var is_saved: Bool?
    var metric: Metric?
    
}

struct ExperienceCategories: Decodable, Identifiable {
    var id: Int
    var parent_ID: Int
    var title: String
}

struct ImageObj: Decodable {
    let image: String?
}

struct ExpCat: Decodable {
    let first_category: String?
    let second_category: String?
}

struct Metric: Decodable{
    let see: Int
    let bought: Int
}
struct HostObj: Decodable {
    var title: String
    var count: Int
}
struct Experience: Decodable, Identifiable {
    let id: Int
    let title: String
    let average: Float
    let review_count: Int
    let host: HostObj
    let durability: Int
    let what_to_expect: String
    let min_price: Float
    let image: ImageObj
    let content_type: Int
    let format_type: Int
    let category: ExpCat
    let is_saved: Bool
    let metric: Metric
}



