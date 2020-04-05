//
//  SearchRequest.swift
//  InTune
//
//  Created by Akashlal on 28/03/20.
//  Copyright © 2020 AkOS. All rights reserved.
//

import Foundation


enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

class SearchRequest: NSObject{
    
    class func parseMovieResponse(data: Data?) -> (SearchResultModel?, String?){
        guard let data = data else{
            //Data corrupted, should never happen
            return (nil, JSONError.NoData.rawValue)
        }
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(SearchResultModel.self, from: data)
            //Returning proper data
            return (decodedData, nil)
        } catch {
            //Conversion failed because of invalid model file
            return(nil, JSONError.ConversionFailed.rawValue)
        }
    }
    
    class func with(query: String, completionHandler: @escaping (SearchResultModel?, String?) -> Void){
        guard let urlQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
            let url = URL(string: "https://itunes.apple.com/search?term=\(urlQuery)") else {
                //Should never happen
                fatalError()
        }
        
        //Result tuple to be returned via closure
        var result: (data: SearchResultModel?, errorMessage: String?)
        
        //Performing get request
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                //Any network error ie. offline etc
                completionHandler(nil, error.localizedDescription)
            }
            else{
                result = parseMovieResponse(data: data)
                completionHandler(result.data, result.errorMessage)
            }
        }.resume()
    }
}
