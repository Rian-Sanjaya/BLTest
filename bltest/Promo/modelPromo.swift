//
//  modelPromo.swift
//  bltest
//
//  Created by Rian Sanjaya Ng on 06/02/19.
//  Copyright © 2019 Rian Sanjaya Ng. All rights reserved.
//

import Foundation

class modelPromo : NSObject{
    var deskripsiUrl : String
    var imageUrl : String
    
    init(deskripsiUrl: String, imageUrl : String){
        self.deskripsiUrl = deskripsiUrl
        self.imageUrl = imageUrl
    }
}
