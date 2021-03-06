//
//  PhotoPicker.swift
//  quickChat
//
//  Created by User on 7/25/16.
//  Copyright © 2016 User. All rights reserved.
//

import Foundation
import Photos
// this class uses Photo framework that Apple provide to load all media item in user album
// the result is grouped by smart album feature in iOS.
// you can check the groups by switching album in choose photo screen
class PhotoPicker {
    
    var selectedAlbum = [SmartAlbum]()
    var currentAlbum : SmartAlbum! = nil
    var cameraRoll : SmartAlbum! = nil
    let selectedPhoto = [UIImage]()
    var currentAlbumIndex : Int = 0
    
    init() {
        getSmartAlbum()
    }
    
    func getSmartAlbum() {
        let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .AlbumRegular, options: nil)
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        smartAlbums.enumerateObjectsUsingBlock( {
            if let assetCollection = $0.0 as? PHAssetCollection {
                print("album title: \(assetCollection.localizedTitle)")
                let assetsFetchResult = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: allPhotosOptions)
                let numberOfAssets = assetsFetchResult.count
                if numberOfAssets != 0 && assetCollection.localizedTitle! != "Videos" {
                    self.selectedAlbum.append(SmartAlbum(albumName: assetCollection.localizedTitle!, albumCount: numberOfAssets, albumContent: assetsFetchResult))
                    if assetCollection.localizedTitle! == "Camera Roll" {
                        self.cameraRoll = SmartAlbum(albumName: assetCollection.localizedTitle!, albumCount: numberOfAssets, albumContent: assetsFetchResult)
                        self.currentAlbum = self.cameraRoll
                    }
                }
                let estimatedCount =  (assetCollection.estimatedAssetCount == NSNotFound) ? -1 : assetCollection.estimatedAssetCount
                print("Assets count: \(numberOfAssets), estimate: \(estimatedCount)")
            }
        } )
    }

}