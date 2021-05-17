//
//  Models.swift
//  Final
//
//  Created by Ablai Nuraliev on 16.05.2021.
//

import Foundation

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
    var id: Int
    var date: String
}
struct Days: Decodable {
    var day: [Day]
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
    //    var dates: Days?
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


struct AdultPrice: Decodable
{
    var id: Int
    var adult_x: Int
    var price: Int
}

struct TeenPrice: Decodable
{
    var id: Int
    var teen_x: Int
    var price: Int
}
struct ChildPrice: Decodable
{
    var id: Int
    var child_x: Int
    var price: Int
}
struct Total: Decodable{
    var adult_price: AdultPrice
    var teen_price: TeenPrice
    var child_price: ChildPrice
    var sum: Int
}

struct Option: Decodable{
    var id: Int
    var isFree: Bool
    var title: String
    var subtitle: String
    var total: Total
    
}
