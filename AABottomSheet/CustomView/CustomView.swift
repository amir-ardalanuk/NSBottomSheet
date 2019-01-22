//
//  CustomView.swift
//  AABottomSheet
//
//  Created by Amir Ardalan on 1/15/19.
//  Copyright © 2019 golrang. All rights reserved.
//

import UIKit

class CustomView: BottomSheetCustomView , Connectable {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commit()
        BottomSheetHeight = 240
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commit()
        BottomSheetHeight = 240
    }

    
    
}
