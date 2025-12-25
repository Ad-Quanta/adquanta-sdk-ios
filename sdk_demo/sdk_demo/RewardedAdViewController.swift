//
//  RewardedAdViewController.swift
//  sdk_demo
//
//  Created by tomlu on 2025/12/25.
//

import UIKit
import adquanta_ads_sdk

class RewardedAdViewController: UIViewController {
    
    var logLabel: UILabel!
    var loadButton: UIButton!
    var showButton: UIButton!
    
    var rewardedAd: AdQuantaRewarded?
    
    // Ad Unit ID 来自 tradplus-ios-demo-main
    let adUnitID = "160AFCDF01DDA48CCE0DBDBE69C8C669"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initRewardedAd()
    }
    
    func setupUI() {
        title = "激励视频广告"
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
    
    func initRewardedAd() {
        rewardedAd = AdQuantaRewarded(adUnitID: adUnitID)
        rewardedAd?.delegate = self
    }
    
    @objc func loadAd() {
        logLabel.text = "开始加载..."
        loadButton.isEnabled = false
        showButton.isEnabled = false
        
        rewardedAd?.loadAd()
    }
    
    @objc func showAd() {
        logLabel.text = ""
        rewardedAd?.showAd(withSceneId: nil)
    }
}

// MARK: - AdQuantaAdDelegate
extension RewardedAdViewController: AdQuantaAdDelegate {
    func adQuantaAd(_ ad: AdQuantaAd, didLoadWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "✅ 加载成功"
            self.loadButton.isEnabled = true
            self.showButton.isEnabled = true
            print("Rewarded Ad Loaded: \(adInfo)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didLoadFailWithError error: Error) {
        DispatchQueue.main.async {
            self.logLabel.text = "❌ 加载失败: \(error.localizedDescription)"
            self.loadButton.isEnabled = true
            self.showButton.isEnabled = false
            print("Rewarded Ad Load Failed: \(error)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didShowWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "✅ 广告已展示"
            print("Rewarded Ad Shown: \(adInfo)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didShowFailWithInfo adInfo: [AnyHashable : Any], error: Error) {
        DispatchQueue.main.async {
            self.logLabel.text = "❌ 展示失败: \(error.localizedDescription)"
            print("Rewarded Ad Show Failed: \(error)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didClickWithInfo adInfo: [AnyHashable : Any]) {
        print("Rewarded Ad Clicked: \(adInfo)")
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didCloseWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "广告已关闭"
            self.showButton.isEnabled = false
            print("Rewarded Ad Closed: \(adInfo)")
        }
    }
    
    func adQuantaAd(_ ad: AdQuantaAd, didRewardWithInfo adInfo: [AnyHashable : Any]) {
        DispatchQueue.main.async {
            self.logLabel.text = "🎉 奖励完成！"
            print("Rewarded Ad Reward: \(adInfo)")
            
            // 显示奖励提示
            let alert = UIAlertController(title: "奖励", message: "恭喜您获得奖励！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func viewController(forPresentingModalView ad: AdQuantaAd) -> UIViewController? {
        return self
    }
}

