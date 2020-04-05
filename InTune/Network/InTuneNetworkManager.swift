//
//  InTuneNetworkManager.swift
//  InTune
//
//  Created by Akashlal on 28/03/20.
//  Copyright © 2020 AkOS. All rights reserved.
//

import Foundation

protocol InTuneNetworkManagerDelegate{
    func getSearchResultsSuccessful(items: [MusicItem])
    func noSearchResultsFound()
    func getSearchResultsFailed(error: String)
    
    func showLoader()
    func hideLoader()
}

class InTuneNetworkManager: NSObject {
    var delegate : InTuneNetworkManagerDelegate!
    
    //Singleton Pattern
    private override init() {
        super.init()
    }
    
    //Creating Shared instance of this class for Singleton Impementation
    private static var sharedInstance: InTuneNetworkManager {
        return InTuneNetworkManager()
    }
    
    //Exposing public method to get shared instance of InTuneNetworkManager - Singleton Pattern
    public static func shared() -> InTuneNetworkManager {
        return InTuneNetworkManager.sharedInstance
    }
}
 
// MARK:- Public Methods
extension InTuneNetworkManager{
    public func getSearchResults(for query: String){
        self.search(for: query)
        delegate.showLoader()
    }
    
}

// MARK:- Private Methods
extension InTuneNetworkManager{
    private func search(for query: String){
        SearchRequest.with(query: query){ (searchResultsModel, error) in
            //To ensure loader is hidden no matter the network output
            defer{
                self.delegate.hideLoader()
            }
            if let error = error{
                self.delegate.getSearchResultsFailed(error: error)
            }
            guard let results = searchResultsModel?.results else {
                self.delegate.getSearchResultsFailed(error: "This shouldn't have happened! Please try again")
                return
            }
            if results.count == 0{
                self.delegate.noSearchResultsFound()
            }
            else{
                let songs = results.filter { $0.kind == "song" }
                self.delegate.getSearchResultsSuccessful(items: songs)
            }
        }
    }

}

