//
//  BannerAdViewController.swift
//  sdk_demo
//
//  Created by tomlu on 2025/12/25.
//

import UIKit
import adquanta_ads_sdk

class BannerAdViewController: UIViewController {
    
    var logLabel: UILabel!
    var adView: UIView!
    var loadButton: UIButton!
    var showButton: UIButton!
    
    var bannerAd: AdQuantaBanner?
    
    // Ad Unit ID 来自 tradplus-ios-demo-main
    let adUnitID = "6008C47DF1201CC875F2044E88FCD287"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initBannerAd()
    }
    
    func setupUI() {
        title = "Banner 广告"
        view.backgroundColor = .white
        
        // 创建 adView
        adView = UIView()
        adView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        adView.layer.borderColor = UIColor.lightGray.cgColor
        adView.layer.borderWidth = 1.0
        view.addSubview(adView)
        adView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            adView.widthAnchor.constraint(equalToConstant: 320),
            adView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // 创建加载按钮
        loadButton = UIButton(type: .system)
        loadButton.setTitle("加载广告", for: .normal)
        loadButton.addTarget(self, action: #selector(loadAd), for: .touchUpInside)
        view.addSubview(loadButton)
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadButton.topAnchor.constraint(equalTo: adView.bottomAnchor, constant: 40)
        ])
        
        // 创建展示按钮
        showButton = UIButton(type: .system)
        showButton.setTitle("展示广告", for: .normal)
        showButton.addTarget(self, action: #selector(showAd), for: .touchUpInside)
        showButton.isEnabled = false
        view.addSubview(showButton)
        showButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showButton.topAnchor.constraint(equalTo: loadButton.bottomAnchor, constant: 20)
        ])
        
        // 创建日志标签
        logLabel = UILabel()
        logLabel.text = "点击加载广告"
        logLabel.textAlignment = .center
        logLabel.numberOfLines = 0
        view.addSubview(logLabel)
        logLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logLabel.topAnchor.constraint(equalTo: showButton.bottomAnchor, constant: 40),
            logLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func initBannerAd() {
        bannerAd = AdQuantaBanner(adUnitID: adUnitID, frame: adView.bounds)
        bannerAd?.delegate = self
        bannerAd?.autoShow = true // 自动展示
    }
    
    @objc func loadAd() {
        logLabel.text = "开始加载..."
        loadButton.isEnabled = false
        showButton.isEnabled = false
        
        bannerAd?.loadAd(withSceneId: nil)
    }
    
    @objc func showAd() {
        logLabel.text = ""
        bannerAd?.show(withSceneId: nil)
    }
}

// MARK: - AdQuantaAdDelegate
extension BannerAdViewController: AdQuantaAdDelegate {
    func adQuantaAd(_ ad: AdQuantaAd, didLoadWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "✅ 加载成功"
            self.loadButton.isEnabled = true
            self.showButton.isEnabled = true
            
            // 如果设置了 autoShow，广告会自动展示
            if let banner = self.bannerAd, banner.autoShow {
                let bannerView = banner.bannerView
                self.adView.addSubview(bannerView)
                bannerView.frame = self.adView.bounds
            }
            
            print("Banner Ad Loaded: \(adInfo)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didLoadFailWithError error: Error) {
        DispatchQueue.main.async {
            self.logLabel.text = "❌ 加载失败: \(error.localizedDescription)"
            self.loadButton.isEnabled = true
            self.showButton.isEnabled = false
            print("Banner Ad Load Failed: \(error)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didShowWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "✅ 广告已展示"
            print("Banner Ad Shown: \(adInfo)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didShowFailWithInfo adInfo: [AnyHashable : Any], error: Error) {
        DispatchQueue.main.async {
            self.logLabel.text = "❌ 展示失败: \(error.localizedDescription)"
            print("Banner Ad Show Failed: \(error)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didClickWithInfo adInfo: [AnyHashable : Any]) {
        print("Banner Ad Clicked: \(adInfo)")
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didCloseWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "广告已关闭"
            print("Banner Ad Closed: \(adInfo)")
        }
    }
    
    func viewController(forPresentingModalView ad: AdQuantaAd) -> UIViewController? {
        return self
    }
}

