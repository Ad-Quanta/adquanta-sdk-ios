//
//  ViewController.swift
//  sdk_demo
//
//  Created by tomlu on 2025/12/25.
//

import UIKit
import adquanta_ads_sdk

class ViewController: UIViewController {
    
    var tableView: UITableView!
    
    // 广告类型列表
    let adTypes = [
        ("开屏广告", "Splash Ad"),
        ("Banner 广告", "Banner Ad"),
        ("插屏广告", "Interstitial Ad"),
        ("激励视频广告", "Rewarded Ad")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        title = "AdQuanta SDK Demo"
        view.backgroundColor = .white
        
        // 设置导航栏
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // 创建表格视图（如果不存在）
        if tableView == nil {
            tableView = UITableView(frame: view.bounds, style: .plain)
            tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(tableView)
        }
        
        // 设置表格视图
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1.0)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let adType = adTypes[indexPath.row]
        cell.textLabel?.text = adType.0
        cell.detailTextLabel?.text = adType.1
        cell.textLabel?.textColor = UIColor(red: 0.42, green: 0.66, blue: 0.85, alpha: 1.0)
        cell.detailTextLabel?.textColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.0)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var viewController: UIViewController?
        
        switch indexPath.row {
        case 0: // 开屏广告
            viewController = SplashAdViewController()
        case 1: // Banner 广告
            viewController = BannerAdViewController()
        case 2: // 插屏广告
            viewController = InterstitialAdViewController()
        case 3: // 激励视频广告
            viewController = RewardedAdViewController()
        default:
            break
        }
        
        if let vc = viewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
