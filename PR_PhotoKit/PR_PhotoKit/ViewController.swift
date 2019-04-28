//
//  ViewController.swift
//  PR_PhotoKit
//
//  Created by Hyeontae on 28/04/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var centerLabel: UILabel!
    
    
    var allPhotos: PHFetchResult<PHAsset>!
    // Asset 자체는 MetaData 만 담고 있다. 만약에 이미지나 비디오등의 정보가 필요하다면
    // ImageManager 를 사용하자
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let allPhotosOptions = PHFetchOptions()
//        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: #keyPath(PHAsset.creationDate), ascending: true)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        PHPhotoLibrary.shared().register(self)
        
        allPhotos.enumerateObjects { (asset, num, pointer) in
            print(asset.location , num , pointer)
        }
        let indx = IndexSet(integersIn: Range(NSRange(location: 0, length: 8))!)
        let temp = allPhotos.objects(at: indx).filter { (asset) -> Bool in
            print(asset.location)
            return asset.location != nil
        }
        
        print("good")
        print(temp.count)
        print("good")
    }

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }

}

extension ViewController: PHPhotoLibraryChangeObserver {
    // 변화가 일어나면 여기서 캐치한다.
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        // Change notifications may originate from a background queue.
        // Re-dispatch to the main queue before acting on the change,
        // so you can update the UI.
        DispatchQueue.main.sync {
            // Check each of the three top-level fetches for changes.
            if let changeDetails = changeInstance.changeDetails(for: allPhotos) {
                // Update the cached fetch result.
                allPhotos = changeDetails.fetchResultAfterChanges
                // Don't update the table row that always reads "All Photos."
                // 변화를 자동으로 감지해서 해당 코드가 실행된다.
                centerLabel.text = "\(allPhotos.count)"
            }
            
            // Update the cached fetch results, and reload the table sections to match.
//            if let changeDetails = changeInstance.changeDetails(for: smartAlbums) {
//                smartAlbums = changeDetails.fetchResultAfterChanges
//                tableView.reloadSections(IndexSet(integer: Section.smartAlbums.rawValue), with: .automatic)
//            }
//            if let changeDetails = changeInstance.changeDetails(for: userCollections) {
//                userCollections = changeDetails.fetchResultAfterChanges
//                tableView.reloadSections(IndexSet(integer: Section.userCollections.rawValue), with: .automatic)
//            }
        }
    }
    
    
}

