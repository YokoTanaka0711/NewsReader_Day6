//
//  ListViewController.swift
//  NewsReader_Day6
//
//  Created by 田中陽子 on 2019/10/08.
//  Copyright © 2019 Yoko Tanaka. All rights reserved.
//

import UIKit

//XMLはマークアップ言語の一つ。RSS（要素名と要素で構成される）はXML形式にそって記述される。データ解析のみ実行。結果の扱いにはでデリゲートで指定する必要。
class ListViewController: UITableViewController,XMLParserDelegate{
    
    var parser:XMLParser!
    var items = [Item]()
    var item:Item?
    var currentString = ""
    
    //セルの数を指定する
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //セルの内容を指定する
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDownload()
    }
    
    //itemにURLを
    func startDownload(){
        self.items = [] //先ずはitemを空の状態にする
        if let url = URL(
            string: "http://feeds.lifehacker.jp/rss/lifehacker/index.xml"){
            if let parser = XMLParser(contentsOf: url){
                self.parser = parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
    }
    //必要なデータのみを取り出す処理。要素名の開始タグが見つかるたびに、デリゲートで指定したインスタンスで呼出。
    func parser(_ parser:XMLParser,didStartElement elementName:String,
                namespaceURI nemespaceURI:String?,
                qualifiedName qName:String?,
                attributes attributeDict:[String : String]){
        self.currentString = ""
        if elementName == "item" {
            self.item = Item()
        }
    }
    
    //要素（内容）を取り出す
    func parser(_ parser:XMLParser,foundCharacters string : String){
        self.currentString += string
    }
    
    //終了タグが見つかったら、それぞれの場所に格納する
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "title":self.item?.title = currentString
        case "link":self.item?.link = currentString
        case "item":self.items.append(self.item!)
        default:break
        }
    }
    
    //解析したデータを表示する
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    //記事のデータを次の画面へ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow{ //ユーザーがタップしたindexPathを取得し、itemを取得
            let item = items[indexPath.row]
            let controller = segue.destination as! DetailViewController
            controller.title = item.title
            controller.link = item.link
        }
    }
    
}
