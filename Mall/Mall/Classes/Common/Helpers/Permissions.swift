//
//  Permissions.swift
//  Mall
//
//  Created by midland on 2019/10/30.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit
import AVKit
import Photos

struct Permissions {

    // 相册权限
     static func photoAlbum(authorizedBlock: (() -> ())?, deniedBlock: (() -> ())?) {

         let authStatus = PHPhotoLibrary.authorizationStatus()
         // .notDetermined  .authorized  .restricted  .denied
         if authStatus == .notDetermined {
             // 第一次触发授权 alert
             PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) -> Void in
                 self.photoAlbum(authorizedBlock: authorizedBlock, deniedBlock: deniedBlock)
             }
         } else if authStatus == .authorized {
             if let _ = authorizedBlock {
                 authorizedBlock!()
             }
         } else {
             if let _ = deniedBlock {
                 deniedBlock!()
             }
         }
     }
    
    
    // 相机权限
    static func camera(authorizedBlock: (() -> ())?, deniedBlock: (() -> ())?) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        // .notDetermined  .authorized  .restricted  .denied
        if authStatus == .notDetermined {
            // 第一次触发授权 alert
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                self.camera(authorizedBlock: authorizedBlock, deniedBlock: deniedBlock)
            })
        } else if authStatus == .authorized {
            if let _ = authorizedBlock {
                authorizedBlock!()
            }
        } else {
            if let _ = deniedBlock {
                deniedBlock!()
            }
        }
    }
}
