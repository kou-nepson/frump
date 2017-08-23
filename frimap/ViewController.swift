//
//  ViewController.swift
//  frimap
//
//  Created by 杉山航 on 2017/08/23.
//  Copyright © 2017年 杉山航. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, UISearchBarDelegate {
    
    //商品名を入れるための配列
    var goods_Array = [String]()
    //商品を表示するためのtableview
    @IBOutlet var goods_View: UITableView!
    //商品を探すサーチバー
    @IBOutlet weak var goods_Search: UISearchBar!
    
    //検索結果配列
    var searchResult = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //テーブルビューのデータソースメソッドはviewControllerクラスに書く、という設定
        goods_View.dataSource = self
        //テーブルビューのデリゲートメソッドはビューコントローラークラスに書く、という設定
        goods_View.delegate = self
        //デリゲート先を自分に設定する。
        goods_Search.delegate = self
        //何も入力されていなくてもReturnキーを押せるようにする。
        goods_Search.enablesReturnKeyAutomatically = false
        //検索結果配列にデータをコピーする。
        searchResult = goods_Array
        goods_Array = ["東京都庁","エイブラハムリンカーン","ダリのひげ"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("配列の中身の数\(goods_Array.count)")
        
        //セルを配列の要素に追加する（連動？）
        return goods_Array.count
        
    }
    // ID付きのセルを取得して、セル付属のtextLabelにテストと表示させる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        //セルに商品名を追加する
        cell?.textLabel?.text = goods_Array[indexPath.row]
        return cell!
    }
    //セルが押された時のメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("%@が呼ばれました", goods_Array[indexPath.row])
        
    }
    
    //データの個数を返すメソッド
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return searchResult.count
    }
    
    
    
    //検索ボタン押下時の呼び出しメソッド
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        goods_Search.endEditing(true)
        
        //検索結果配列を空にする。
        searchResult.removeAll()
        
        if(goods_Search.text == "") {
            //検索文字列が空の場合はすべてを表示する。
            searchResult = goods_Array
        } else {
            //検索文字列を含むデータを検索結果配列に追加する。
            for data in goods_Array {
//                if data(UISearchBar!) {
//                    searchResult.append(data)
//                }
            }
        }
        
        //テーブルを再読み込みする。
        goods_View.reloadData()
    }
    
    
}

