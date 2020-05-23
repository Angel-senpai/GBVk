//
//  PhotoRepository.swift
//  GBVk
//
//  Created by Даниил Мурыгин on 29.02.2020.
//  Copyright © 2020 Даниил Мурыгин. All rights reserved.
//

import RealmSwift

/*class PhotoRepositoryRealm{
    func addPhoto(albumId:Int = 0,
        date:Int = 0,
        id: Int = 0,
        ownerId: Int = 0,
        text: String?,
        sizes: PhotoSizesRealm,
        extended: PhotoRealm.PhotoExtended?) {
        let realm = try? Realm()
        let newPhoto = PhotoRealm()
        newPhoto.albumId = albumId
        newPhoto.date = date
        newPhoto.id = id
        newPhoto.ownerId = ownerId
        newPhoto.text = text
        newPhoto.sizes.append(sizes)
        newPhoto.extended = extended
        try? realm?.write {
            realm?.add(newPhoto, update: .modified)
        }
        
    }
}*/
