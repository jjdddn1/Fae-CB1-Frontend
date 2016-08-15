//
//  PhotoPickerCollectionViewCell.swift
//  quickChat
//
//  Created by User on 7/14/16.
//  Copyright © 2016 User. All rights reserved.
//

import UIKit

class PhotoPickerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ChosenFrameImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoImageView.layer.zPosition = 1
        photoImageView.contentMode = .ScaleAspectFill
        ChosenFrameImageView.layer.zPosition = 10
        ChosenFrameImageView.hidden = true
    }
    
    func setImage(thumbnailImage : UIImage) {
        photoImageView.image = thumbnailImage
    }

    override func prepareForReuse() {
        print("prepare for reuse")
        photoImageView.image = nil
        ChosenFrameImageView.hidden = true
    }
}
