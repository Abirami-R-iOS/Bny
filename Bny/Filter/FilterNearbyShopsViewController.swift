//
//  FilterViewController.swift
//  Bny
//
//  Created by Abirami on 06/08/26.
//

import UIKit

import UIKit

final class FilterNearbyShopsViewController:UIViewController{

@IBOutlet weak var backBtn:UIButton!
@IBOutlet weak var titleLbl:UILabel!
@IBOutlet weak var subTitleLbl:UILabel!
@IBOutlet weak var scrollView:UIScrollView!

@IBOutlet weak var searchRadiusCardView:UIView!
@IBOutlet weak var radiusTitleLbl:UILabel!
@IBOutlet weak var radiusSubTitleLbl:UILabel!
@IBOutlet weak var radiusValueView:UIView!
@IBOutlet weak var radiusValueLbl:UILabel!
@IBOutlet weak var radiusSlider:UISlider!

@IBOutlet weak var quickSelectTitleLbl:UILabel!
@IBOutlet weak var oneKmBtn:UIButton!
@IBOutlet weak var threeKmBtn:UIButton!
@IBOutlet weak var fiveKmBtn:UIButton!
@IBOutlet weak var tenKmBtn:UIButton!
@IBOutlet weak var twentyFiveKmBtn:UIButton!
@IBOutlet weak var fiftyKmBtn:UIButton!

@IBOutlet weak var viewOnMapCardView:UIView!
@IBOutlet weak var noShopCardView:UIView!

@IBOutlet weak var clearFilterBtn:UIButton!
@IBOutlet weak var applyFilterBtn:UIButton!

private var selectedRadius=50

override func viewDidLoad(){
super.viewDidLoad()
initialSetup()
configureSlider()
updateRadiusSelection(radius:50)
}

private func initialSetup(){
navigationController?.isNavigationBarHidden=true
[searchRadiusCardView,viewOnMapCardView,noShopCardView].forEach{
$0?.layer.cornerRadius=18
$0?.layer.borderWidth=1
$0?.layer.borderColor=UIColor.white.withAlphaComponent(0.08).cgColor
$0?.clipsToBounds=true
}
radiusValueView.layer.cornerRadius=20
radiusValueView.layer.borderWidth=1
radiusValueView.layer.borderColor=UIColor.systemPink.cgColor
[oneKmBtn,threeKmBtn,fiveKmBtn,tenKmBtn,twentyFiveKmBtn,fiftyKmBtn].forEach{
$0?.layer.cornerRadius=10
$0?.backgroundColor=UIColor(red:16/255,green:24/255,blue:39/255,alpha:1)
$0?.setTitleColor(.white,for:.normal)
}
clearFilterBtn.layer.cornerRadius=14
clearFilterBtn.layer.borderWidth=1
clearFilterBtn.layer.borderColor=UIColor.white.withAlphaComponent(0.1).cgColor
applyFilterBtn.layer.cornerRadius=14
}

private func configureSlider(){
radiusSlider.minimumValue=1
radiusSlider.maximumValue=50
radiusSlider.value=50
}

private func updateRadiusSelection(radius:Int){
selectedRadius=radius
radiusValueLbl.text="\(radius) km"
radiusSlider.setValue(Float(radius),animated:true)
let map:[Int:UIButton]=[1:oneKmBtn,3:threeKmBtn,5:fiveKmBtn,10:tenKmBtn,25:twentyFiveKmBtn,50:fiftyKmBtn]
map.values.forEach{
$0.backgroundColor=UIColor(red:16/255,green:24/255,blue:39/255,alpha:1)
}
if let btn=map[radius]{
    btn.backgroundColor = .bnyRed
}
}

@IBAction func sliderChanged(_ sender:UISlider){
let values=[1,3,5,10,25,50]
let nearest=values.min(by:{abs($0-Int(sender.value))<abs($1-Int(sender.value))}) ?? 50
updateRadiusSelection(radius:nearest)
}
@IBAction func oneKmAction(_ sender:UIButton){updateRadiusSelection(radius:1)}
@IBAction func threeKmAction(_ sender:UIButton){updateRadiusSelection(radius:3)}
@IBAction func fiveKmAction(_ sender:UIButton){updateRadiusSelection(radius:5)}
@IBAction func tenKmAction(_ sender:UIButton){updateRadiusSelection(radius:10)}
@IBAction func twentyFiveKmAction(_ sender:UIButton){updateRadiusSelection(radius:25)}
@IBAction func fiftyKmAction(_ sender:UIButton){updateRadiusSelection(radius:50)}
@IBAction func clearFilterAction(_ sender:UIButton){updateRadiusSelection(radius:50)}
@IBAction func applyFilterAction(_ sender:UIButton){}
@IBAction func viewOnMapAction(_ sender:UIButton){}
@IBAction func backAction(_ sender:UIButton){navigationController?.popViewController(animated:true)}
}
