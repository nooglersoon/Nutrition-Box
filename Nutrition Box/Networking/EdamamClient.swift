//
//  EdamamClient.swift
//  Nutrition Box
//
//  Created by Fauzi Achmad B D on 11/09/21.
//

import Foundation

class EdamamClient {
    
    struct Auth {
        
        static let appID: String = "73f131bb"
        static let appKey: String = "955aa2d45f5e6bde2cadd936119f2142"
        
    }
    
    enum Endpoints {
        
        static let baseURL: String = "https://api.edamam.com/api/nutrition-data?"
        
        case nutritionAnalysis(String, String, String)
        
        var strValue: String {
            
            switch self {
            
            case .nutritionAnalysis(let appID, let appKey, let foodParams):
                return EdamamClient.Endpoints.baseURL + "app_id=\(appID)"+"&app_key=\(appKey)"+"&nutrition-type=cooking"+"&ingr=1%20\(foodParams)"

            }
            
        }
        
        var url: URL {
            
            return URL(string: strValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        }
        
    }
    
    
    class func getNutrionAnalysis(foodParam: String, completion: @escaping (EdamamResponseCode?,EdamamResponse?,Error?)->Void){
        
        let request: URL = Endpoints.nutritionAnalysis(Auth.appID, Auth.appKey, foodParam).url
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                debugPrint("Error, The data is nil")
                debugPrint(response!)
                completion(nil,nil,error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                
                let responseObj = try decoder.decode(EdamamResponse.self, from: data)
                
                DispatchQueue.main.async {
                    
                    completion(nil,responseObj, nil)
                    
                }
                
                
            } catch {
                
                debugPrint("Failed to Decode Data")
                
                DispatchQueue.main.async {
                    completion(nil,nil,error)
                }
                
            }
            
            
        }
        
        task.resume()
        
        
        
    }
    
}
