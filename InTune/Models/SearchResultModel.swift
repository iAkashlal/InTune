//
//  SearchResultModel.swift
//  InTune
//
//  Created by Akashlal on 28/03/20.
//  Copyright © 2020 AkOS. All rights reserved.
//

import Foundation

public struct SearchResultModel: Codable{

    var resultCount : Int!
    var results : [MusicItem]!


}

public class MusicItem: Codable{
    //To show in list view
    var trackName : String!
    var artistName : String!
    var primaryGenreName : String!
    var trackTimeMillis : Int!
    //Converting MS into mm:ss assuming song wont last for hours.
    var trackTimeString: String{
        guard let trackTimeMillis = trackTimeMillis else{ return "Unknown"}
        let seconds = ((trackTimeMillis/1000)%60)
        let minutes = ((trackTimeMillis/(1000*60))%60)
        let minutesString = (minutes < 10) ? "0\(minutes)" : "\(minutes)"
        let secondsString = (seconds < 10) ? "0\(seconds)" : "\(seconds)"

        return "\(minutesString) : \(secondsString)"
    }
    var trackPrice : Float!
    var artworkUrl100 : String!
    var kind : String!
    
    //Additional data received from API
    var releaseDate : String!
    var trackCensoredName : String!
    var contentAdvisoryRating : String!

    var collectionCensoredName : String!
    var collectionExplicitness : String!
    var collectionPrice : Float!
    
    var country : String!
    var currency : String!
    var releaseString: String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        if let date = dateFormatterGet.date(from: releaseDate) {
            return (dateFormatterPrint.string(from: date))
        } else {
           return "Unknown"
        }
    }
    
    
    //Data which is of no use
    var artistId : Int!
    var artistViewUrl : String!
    var artworkUrl60 : String!
    var artworkUrl30 : String!
    var collectionArtistId : Int!
    var collectionArtistName : String!
    var collectionId : Int!
    var collectionViewUrl : String!
    var discCount : Int!
    var discNumber : Int!
    var isStreamable : Bool!
    var previewUrl : String!
    var trackId : Int!
    var trackNumber : Int!
    var trackViewUrl : String!
    var wrapperType : String!
    var trackCount : Int!
    var collectionName : String!
    var trackExplicitness : String!
}
