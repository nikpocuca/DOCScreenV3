//
//  ViewController.swift
//  DOCCompiler
//
//  Created by Nik on 2018-05-11.
//  Copyright © 2018 Nik. All rights reserved.
//

import UIKit
import PDFGenerator


class DocCompilerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        CreatePDF()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

func createLabel(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String) -> UILabel {
    let newUILabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height));
    newUILabel.text = text;
    return newUILabel
}

func CreatePDF() {
    let formView = UIView(frame: CGRect(x: 0, y: 0, width: 1275, height: 1650))
    formView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "DOCForm.png"))
    
    let check = "✓"
    
    
    let nameLabel = createLabel(x: 415, y: 144, width: 200, height: 21, text:"namePlaceholder")
    let dateLabel = createLabel(x: 882, y: 144, width: 295, height: 21, text: "datePlaceholder")
    let ageLabel = createLabel(x: 400, y: 219, width: 100, height: 21, text: "age")
    let sexLabel = createLabel(x: 697, y: 219, width: 115, height: 21, text: "sexPlaceholder")
    let eduLabel = createLabel(x: 1070, y: 219, width: 63, height: 21, text: "educationPlace")
    let heightLabel = createLabel(x: 415, y: 257, width: 100, height: 21, text: "heightPlaceholder")
    let weightLabel = createLabel(x: 723, y: 257, width: 100, height: 21, text: "weightPlaceholder")
    let bmLabel = createLabel(x: 999, y: 256, width: 100, height: 21, text: "BMIPlaceholder")
    let f1Label = createLabel(x: 637, y: 322, width: 63, height: 21, text: "f1")
    let f2Label = createLabel(x: 637, y: 355, width: 63, height: 21, text: "f2")
    let v1Label = createLabel(x: 733, y: 322, width: 63, height: 21, text: "v1")
    let v2Label = createLabel(x: 733, y: 355, width: 63, height: 21, text: "v2")
    let c1Label = createLabel(x: 853, y: 322, width: 63, height: 21, text: "c1")
    let c2Label = createLabel(x: 853, y: 355, width: 63, height: 21, text: "c2")
    let d1Label = createLabel(x: 949, y: 322, width: 63, height: 21, text: "d1")
    let d2Label = createLabel(x: 949, y: 355, width: 63, height: 21, text: "d2")
    let r1Label = createLabel(x: 1045, y: 322, width: 63, height: 21, text: "r1")
    let r2Label = createLabel(x: 1045, y: 359, width: 63, height: 21, text: "r2")
    let mQ1zeroLabel = createLabel(x: 599, y: 467, width: 63, height: 21, text: "zero")
    let mQ2zeroLabel = createLabel(x: 599, y: 504, width: 63, height: 21, text: "zero2")
    let mQ1oneLabel = createLabel(x: 733, y: 467, width: 63, height: 21, text: "one")
    let mQ2oneLabel = createLabel(x: 733, y: 504, width: 63, height: 21, text: "one2")
    let mQ1twoLabel = createLabel(x: 882, y: 467, width: 63, height: 21, text: "two")
    let mQ2twoLabel = createLabel(x: 882, y: 504, width: 63, height: 21, text: "two2")
    let mQ1threeLabel = createLabel(x: 1027, y: 467, width: 63, height: 21, text: "three")
    let mQ2threeLabel = createLabel(x: 1027, y: 504, width: 63, height: 21, text: "three2")
    let moodScoreLabel = createLabel(x: 1139, y: 479, width: 63, height: 21, text: "MD")
    let q1ApYLabel = createLabel(x: 932, y: 574, width: 63, height: 21, text: "q1Y")
    let q1ApNLabel = createLabel(x: 1045, y: 574, width: 63, height: 21, text: "q1N")
    let q2ApYLabel = createLabel(x: 932, y: 606, width: 63, height: 21, text: "q2Y")
    let q2ApNlabel = createLabel(x: 1045, y: 606, width: 63, height: 21, text: "q2N")
    let q3ApYLabel = createLabel(x: 932, y: 639, width: 63, height: 21, text: "q3Y")

    let q3ApNLabel = createLabel(x: 1045, y: 639, width: 63, height: 21, text: "q3N")
    
    let q4ApYLabel = createLabel(x: 932, y: 669, width: 63, height: 21, text: "q4Y")
    
    let q4ApNLabel = createLabel(x: 1045, y: 669, width: 63, height: 21, text: "q4N")
    
    let apneaScoreLabel = createLabel(x: 1139, y: 632, width: 63, height: 21, text: "Ap1")
    let af1Label = createLabel(x: 637, y: 1196, width: 63, height: 21, text: "af1")
    let af2Label = createLabel(x: 637, y: 1230, width: 63, height: 21, text: "af2")
    let af3Label = createLabel(x: 637, y: 1263, width: 63, height: 21, text: "af3")
    let av1Label = createLabel(x: 733, y: 1196, width: 63, height: 21, text: "av1")
    let av2Label = createLabel(x: 733, y: 1230, width: 63, height: 21, text: "av2")
    let av3Label = createLabel(x: 733, y: 1263, width: 63, height: 21, text: "av3")
    let ac1Label = createLabel(x: 843, y: 1196, width: 63, height: 21, text: "ac1")
    let ac2Label = createLabel(x: 843, y: 1230, width: 63, height: 21, text: "ac2")
    let ac3Label = createLabel(x: 843, y: 1263, width: 63, height: 21, text: "ac3")
    let ad1Label = createLabel(x: 949, y: 1196, width: 63, height: 21, text: "ad1")
    let ad2Label = createLabel(x: 949, y: 1230, width: 63, height: 21, text: "ad2")
    let ad3Label = createLabel(x: 949, y: 1263, width: 63, height: 21, text: "ad3")
    let ar1Label = createLabel(x: 1054, y: 1196, width: 63, height: 21, text: "ar1")
    let ar2Label = createLabel(x: 1054, y: 1230, width: 63, height: 21, text: "ar2")
    let ar3Label = createLabel(x: 1054, y: 1263, width: 63, height: 21, text: "ar3")
    let memoryScoreLabel = createLabel(x: 1135, y: 1239, width: 63, height: 21, text: "memory")
    let tallyMoodScoreLabel = createLabel(x: 1143, y: 1370, width: 63, height: 21, text: "tallyM")
    let tallyApneaScoreLabel = createLabel(x: 1143, y: 1409, width: 63, height: 21, text: "tallyA")
    let tallyCogScoreLabel = createLabel(x: 1135, y: 1450, width: 63, height: 21, text: "tallyC")
    let contourLabel = createLabel(x: 1048, y: 845, width: 63, height: 21, text: check)
    let numbersLabel = createLabel(x: 1048, y: 891, width: 63, height: 21, text: "NX")
    let handsLabel = createLabel(x: 1048, y: 937, width: 63, height: 21, text: "HX")
    let clockScoreLabel =  createLabel(x: 1135, y: 919, width: 63, height: 21, text: "clock")
    let ab1Label = createLabel(x: 312, y: 1123, width: 63, height: 21, text: "ab1")
    let ab2Label = createLabel(x: 833, y: 1123, width: 63, height: 21, text: "ab2")
    let absScore = createLabel(x: 1135, y: 1123, width: 63, height: 21, text: "abstract")
    
    let clockImageView = UIImageView(frame: CGRect(x: 272, y: 735, width: 243.75, height: 325))
    
    clockImageView.image = #imageLiteral(resourceName: "clockTemplate")
    
    let formLabels: [UILabel] = [nameLabel,dateLabel,ageLabel,sexLabel,eduLabel,heightLabel,weightLabel,bmLabel,
        contourLabel,numbersLabel,handsLabel,clockScoreLabel,ab1Label,ab2Label,
   af1Label,af2Label,af3Label,av1Label,av2Label,av3Label,ac1Label,ac2Label,ac3Label,ad1Label,ad2Label,ad3Label,ar1Label, absScore,
   ar2Label,ar3Label,memoryScoreLabel,tallyMoodScoreLabel,tallyApneaScoreLabel,tallyCogScoreLabel,f1Label,f2Label,v1Label,
   v2Label,c1Label,c2Label,d1Label,d2Label,r1Label,r2Label,mQ1zeroLabel,mQ1oneLabel,mQ1twoLabel,mQ1threeLabel,
   mQ2zeroLabel,mQ2oneLabel,mQ2twoLabel,mQ2threeLabel,moodScoreLabel,q1ApYLabel,q1ApNLabel,q2ApYLabel,q2ApNlabel,
   q3ApYLabel,q3ApNLabel,q4ApYLabel,q4ApNLabel,apneaScoreLabel]
    for label in formLabels { formView.addSubview(label) }
    
    formView.addSubview(clockImageView)
    
    do {
        let page: [PDFPage] = [PDFPage.view(formView)
            
        ]
        let path = NSTemporaryDirectory().appending("sample1.pdf")
        print(path);
        try PDFGenerator.generate(page, to: path)
    } catch let error {
        print(error)
    }
    
}
