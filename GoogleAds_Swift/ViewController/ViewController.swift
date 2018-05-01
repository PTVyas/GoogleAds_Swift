//
//  ViewController.swift
//  GoogleAds_Swift
//
//  Created by WOS_MacMini_1 on 28/04/18.
//  Copyright © 2018 White Orange Software. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate, GADRewardBasedVideoAdDelegate {

    @IBOutlet weak var viewBanner_1: GADBannerView!
    @IBOutlet weak var viewBanner_2: GADBannerView!
    @IBOutlet weak var viewBanner_3: GADBannerView!
    @IBOutlet weak var viewBanner_4: GADBannerView!
    
    var interstitial: GADInterstitial! //Interstitial (Full Screen) ad.
    var rewardBasedVideo: GADRewardBasedVideoAd? // The reward-based video ad.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //----------------------------------------------->
        //Google Ads
        //print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        
        self.Google_AdsMob_Banner(view: viewBanner_1)
        self.Google_AdsMob_Banner(view: viewBanner_2)
        self.Google_AdsMob_Banner(view: viewBanner_3)
        self.Google_AdsMob_Banner(view: viewBanner_4)
        
        self.Google_AdsMob_FullScreen()
        self.Google_AdsMob_FullScreen_ShowNow()
        
        self.Google_AdsMob_Video()
        //----------------------------------------------->
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-
    func Google_AdsMob_Banner (view : GADBannerView) {
        view.backgroundColor = MyFunction().getRandomColor()
        
        view.adUnitID = AppConstant.AdsMob_Key_Banner
        view.delegate = self
        view.rootViewController = self
        
        let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        view.load(request)
    }
    
    func Google_AdsMob_FullScreen () {
        interstitial = GADInterstitial(adUnitID:AppConstant.AdsMob_Key_Interstitial)
        interstitial.delegate = self
        
        let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        interstitial.load(request)
        
        self.Google_AdsMob_FullScreen_ShowNow()
    }
    
    func Google_AdsMob_FullScreen_ShowNow () {
        
        //let deadlineTime = DispatchTime.now() + .seconds(10)
        //DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
        
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        }
        else {
            var mess = NSString()
            mess = "Interstitial Ad wasn't ready"
            
            print(mess)
            //MyFunction().showAlertMessage(mess as String, true)
        }
        
        //self.Google_AdsMob_FullScreen_ShowNow()
        //}
    }
    
    func Google_AdsMob_Video () {
        //rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
        //rewardBasedVideo?.delegate = self
        
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),withAdUnitID: AppConstant.AdsMob_Key_Video)
        //GADRewardBasedVideoAd.sharedInstance().delegate = self
    }
    
    func Google_AdsMob_Video_ShowNow ()  {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        else {
            var mess = NSString()
            mess = "Video Ad wasn't ready"
            
            print(mess)
            MyFunction().showAlertMessage(mess as String, true)
        }
    }
    
    // MARK:- Button Action Method
    @IBAction func btnBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnInterstitialAction() {
        self.Google_AdsMob_FullScreen_ShowNow()
    }
    
    @IBAction func btnRewardedVideoAction() {
        self.Google_AdsMob_Video_ShowNow()
    }
    
    // MARK:- Googe MobAds Delegate Action Method
    // MARK: Googe MobAds (Banner)
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
    // MARK: Googe MobAds (Interstitial)
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.Google_AdsMob_FullScreen()
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    // MARK: Googe MobAds (Video)
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }
}

