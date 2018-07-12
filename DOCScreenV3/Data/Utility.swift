//
//  Utility.swift
//  DOCScreenV2
//
//  Created by Nik Pocuca on 2017-10-13.
//  Copyright © 2017 Nik. All rights reserved.
//

import Foundation
import ResearchKit
import CoreVideo
import CoreData
import UIKit

// testing function.

func testData() -> Void {
    
    let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
    
    do {
        
        let subjectArray = try PersistenceService.context.fetch(fetchRequest)
        
        // theres only one subject.
        let subject = subjectArray.first
        print(subjectArray)
        print(subject)

        
        PersistenceService.saveContext()
    }
    catch {print("error getting subject in score clock")}
    
}


func testControl() -> Void {
    
    let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
    
    do {
        
        let controlArray = try PersistenceService.context.fetch(fetchRequest)
        
        var control = controlArray.first
        
        print(control)
    }
    catch {print("testControl has failed")}
    
}


func roundToDecimals(num: CGFloat,decimals: Int = 2) -> CGFloat {
        let multiplier = CGFloat(10^decimals)
        return round(multiplier * num ) / multiplier
    }

public func loadImage(fileName: String) -> UIImage? {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
    do {
        let imageData = try Data(contentsOf: fileURL)
        return UIImage(data: imageData)
    } catch {
        print("Error loading image : \(error)")
    }
    return nil
}



extension String {
    
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }
    
    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}


struct ImageProcessor {
    
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func pixelBuffer (forImage image:CGImage) -> CVPixelBuffer? {
        
        
        let frameSize = CGSize(width: image.width, height: image.height)
        
        var pixelBuffer:CVPixelBuffer? = nil
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32BGRA , nil, &pixelBuffer)
        
        if status != kCVReturnSuccess {
            return nil
            
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        
        context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
        
    }
    
}


func deleteSubjects() -> Void {
    
    do {
        
        _ = try PersistenceService.context.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Subject")))
        PersistenceService.saveContext()
        
        
    } catch {}
    
    
}

func crop(image: UIImage, withWidth width: Double, andHeight height: Double) -> UIImage? {
    
    if let cgImage = image.cgImage {
        
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        var croppedContextImage: CGImage? = nil
        if let contextImage = contextImage.cgImage {
            if let croppedImage = contextImage.cropping(to: rect) {
                croppedContextImage = croppedImage
            }
        }
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        if let croppedImage:CGImage = croppedContextImage {
            let image: UIImage = UIImage(cgImage: croppedImage, scale: image.scale, orientation: image.imageOrientation)
            return image
        }
        
    }
    
    return nil
}

func bool2String(b: Bool?) -> String {
    switch b! {
    case true:
        return("Yes")
    default:
        return("No")
    }
}


func callError() -> UIViewController {
    
    let refreshAlert = UIAlertController(title: "Error loading Task", message: "Please try the task again", preferredStyle: UIAlertControllerStyle.alert)
    
    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in

    }))
 
    return(refreshAlert)
}


func callErrorAlert(title: String, msg: String) -> UIViewController {
    
    let refreshAlert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
    
    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        
    }))
    
    return(refreshAlert)
}


func checkTaskCompletions(control: ControlSettings) -> ControlSettings {
    

    if (control.abstractionComplete && control.apneaComplete && control.clockComplete && control.memoryComplete && control.moodComplete && control.profileComplete ) {
        
        control.fullComplete = true
    }
    
    else { control.fullComplete = false }
    
    return(control)
}


/*
 let fetchRequest: NSFetchRequest<ControlSettings> = ControlSettings.fetchRequest()
 
 do {
 
 let controlArray = try PersistenceService.context.fetch(fetchRequest)
 
 let control = controlArray.first
 
 }  catch { present(callErrorAlert(title: "No Data", msg: "No data has been entered."), animated: true, completion: nil) }
 
 */
