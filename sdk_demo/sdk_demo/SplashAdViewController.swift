//
//  SplashAdViewController.swift
//  sdk_demo
//
//  Created by tomlu on 2025/12/25.
//

import UIKit
import adquanta_ads_sdk

class SplashAdViewController: UIViewController {
    
    var logLabel: UILabel!
    var loadButton: UIButton!
    var showButton: UIButton!
    
    var splashAd: AdQuantaSplash?
    
    // Ad Unit ID 来自 tradplus-ios-demo-main
    let adUnitID = "E5BC6369FC7D96FD47612B279BC5AAE0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initSplashAd()
    }
    
    func setupUI() {
        title = "开屏广告"
        view.backgroundColor = .white
        
        // 创建加载按钮
        loadButton = UIButton(type: .system)
        loadButton.setTitle("加载广告", for: .normal)
        loadButton.addTarget(self, action: #selector(loadAd), for: .touchUpInside)
        view.addSubview(loadButton)
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
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
    
    func initSplashAd() {
        splashAd = AdQuantaSplash(adUnitID: adUnitID)
        splashAd?.delegate = self
    }
    
    @objc func loadAd() {
        logLabel.text = "开始加载..."
        loadButton.isEnabled = false
        showButton.isEnabled = false
        
        guard let window = view.window ?? UIApplication.shared.windows.first else {
            logLabel.text = "错误：无法获取 window"
            loadButton.isEnabled = true
            return
        }
        
        splashAd?.loadAd(with: window, bottomView: nil)
    }
    
    @objc func showAd() {
        logLabel.text = ""
        splashAd?.show()
    }
}

// MARK: - AdQuantaAdDelegate
extension SplashAdViewController: AdQuantaAdDelegate {
    func adQuantaAd(_ ad: AdQuantaAd, didLoadWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "✅ 加载成功"
            self.loadButton.isEnabled = true
            self.showButton.isEnabled = true
            print("Splash Ad Loaded: \(adInfo)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didLoadFailWithError error: Error) {
        DispatchQueue.main.async {
            self.logLabel.text = "❌ 加载失败: \(error.localizedDescription)"
            self.loadButton.isEnabled = true
            self.showButton.isEnabled = false
            print("Splash Ad Load Failed: \(error)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didShowWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "✅ 广告已展示"
            print("Splash Ad Shown: \(adInfo)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didShowFailWithInfo adInfo: [AnyHashable : Any], error: Error) {
        DispatchQueue.main.async {
            self.logLabel.text = "❌ 展示失败: \(error.localizedDescription)"
            print("Splash Ad Show Failed: \(error)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didClickWithInfo adInfo: [AnyHashable : Any]) {
        print("Splash Ad Clicked: \(adInfo)")
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didCloseWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "广告已关闭"
            self.showButton.isEnabled = false
            print("Splash Ad Closed: \(adInfo)")
        }
    }
}

