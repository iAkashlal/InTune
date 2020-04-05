//
//  InTuneModel.swift
//  InTune
//
//  Created by Akashlal on 28/03/20.
//  Copyright © 2020 AkOS. All rights reserved.
//

import Foundation
class InTuneModel: NSObject{

    var manager = InTuneNetworkManager.shared()
    
    //Bindings
    public let loaderVisible = Box(false)
    public let guideViewShown = Box(true)
    public let errorLabelText = Box("")
    public var musicItems = Box([MusicItem]())
    
    private override init() {
        super.init()
        manager.delegate = self
    }
    
    private static var shared: InTuneModel {
        InTuneModel()
    }
    
    static func sharedInstance() -> InTuneModel {
        InTuneModel.shared
    }
    
    public func getSearchResultsFor(query: String){
        manager.getSearchResults(for: query)
    }
}

extension InTuneModel: InTuneNetworkManagerDelegate{
    func getSearchResultsSuccessful(items: [MusicItem]) {
        musicItems.value = items
        guideViewShown.value = false
        errorLabelText.value = ""
    }
    
    func noSearchResultsFound() {
        musicItems.value.removeAll()
        guideViewShown.value = true
        errorLabelText.value = "No songs by that name :( Please rephrase?"
    }
    
    func getSearchResultsFailed(error: String) {
        musicItems.value.removeAll()
        guideViewShown.value = true
        errorLabelText.value = error
    }
    
    func showLoader() {
        loaderVisible.value = true
    }
    
    func hideLoader() {
        loaderVisible.value = false
    }
    
    
}
