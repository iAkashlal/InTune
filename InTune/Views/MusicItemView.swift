//
//  MusicItemView.swift
//  InTune
//
//  Created by Akashlal on 28/03/20.
//  Copyright © 2020 AkOS. All rights reserved.
//

import UIKit
import SDWebImage

class MusicItemCell: UITableViewCell{
    
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackSubtitle: UILabel!
    @IBOutlet weak var trackDuration: UILabel!
    @IBOutlet weak var trackPrice: UILabel!
    
    var trackImageLink: URL!{
        didSet{
            self.trackImage.sd_setImage(with: trackImageLink, completed: nil)
        }
    }
    
}
