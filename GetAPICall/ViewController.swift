//
//  ViewController.swift
//  GetAPICall
//
//  Created by Kumaran on 11/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPICall()
        
        //        getAPICallWithCompletion { (responseData, isSuccess) in
        //            //            if isSuccess == true {
        //            //                print(responseData)
        //            //            } else {
        //            //
        //            //            }
        //            guard isSuccess == true , let bindedResponse = responseData else { return }
        //            print(isSuccess , bindedResponse)
        //        }
    }
    
    func getAPICall() {
        let urlString = "https://dummyjson.com/products"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data , error == nil {
                do {
                    //    let response = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.fragmentsAllowed)
                    //                     Dont Do this above code you will never get resopnse
                    let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    //By the above code you will get response and you have to convert them into dict,arrays by yourself.
                    if let list = response as? NSDictionary{
                        if let productsList = list["products"] as? NSArray {
                            print(productsList)
                        }
                    }
                } catch  {
                    dump(error)
                }
            } else {
                dump(error)
            }
        }
        dataTask.resume()
    }
    
    func getAPICallWithCompletion(completionHandler: @escaping (ResponseData?,Bool) -> Void) {
        
        let urlString = "https://dummyjson.com/products"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data , error == nil {
                do {
                    let response = try JSONDecoder().decode(ResponseData.self, from: data)
                    // By using above code you have to make one model to conver the response into model.
                    completionHandler(response, true)
                } catch  {
                    completionHandler(nil, false)
                    dump(error)
                }
            } else {
                completionHandler(nil, false)
                dump(error)
            }
        }
        dataTask.resume()
    }
}

struct ResponseData: Codable {
    var limit: Int?
    var products: [Produts]?
    var skip: Int?
    var total: Int?
}

struct Produts: Codable {
    var id : Int?
    var title : String?
    var description : String?
    var price : Int?
    var discountPercentage : Double?
    var rating : Double?
    var stock : Int?
    var brand : String?
    var category : String?
    var thumbnail : String?
    var images: [String]?
}

/*
 func fetchPhotoRequest(YOUR_CLIENT_ID: String)  {
 let string = "https://api.inopenapp.com/api/v1/dashboardNew"
 let url = NSURL(string: string)
 let request = NSMutableURLRequest(url: url! as URL)
 request.setValue(YOUR_CLIENT_ID, forHTTPHeaderField: "Access Token") //**
 request.httpMethod = "GET"
 request.addValue("application/json", forHTTPHeaderField: "Content-Type")
 let session = URLSession.shared
 
 let mData = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
 if let res = response as? HTTPURLResponse {
 print("res: \(String(describing: res))")
 print("Response: \(String(describing: response))")
 }else{
 print("Error: \(String(describing: error))")
 }
 }
 mData.resume()
 }
 
 
 func getAPICall() {
 let urlString = "https://dummyjson.com/products"
 guard let url = URL(string: urlString) else { return }
 var request = URLRequest(url: url)
 request.httpMethod = "GET"
 request.addValue("application/json", forHTTPHeaderField: "Content-Type")
 let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
 if let data = data , error == nil {
 do {
 let response = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.fragmentsAllowed)
 let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
 let response = try JSONDecoder().decode(ResponseData.self, from: data)
 dump(response)
 if let list = response as? NSDictionary{
 dump(list)
 if let productsList = list["products"] as? NSArray {
 print(productsList)
 }
 }
 } catch  {
 dump(error)
 }
 } else {
 dump(error)
 }
 }
 dataTask.resume()
 }
 
 */*/
