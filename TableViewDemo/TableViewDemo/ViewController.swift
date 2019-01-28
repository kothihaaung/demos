//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Thiha Aung on 2019/01/25.
//  Copyright © 2019 Thiha Aung. All rights reserved.
//

import UIKit

protocol MemoCellDelegate: class {
    func tappedOnDetail(memoId: String, memoCell: MemoCell)
}

class MemoCell: UITableViewCell {
    
    weak var delegate: MemoCellDelegate?
    
    @IBOutlet weak var memoOverview: UILabel!
    var memoId: String?
    
    @IBAction func tappedOnDetailButton(_ sender: Any) {
        self.delegate?.tappedOnDetail(memoId: self.memoId!, memoCell: self)
    }
}

class ViewController: UIViewController, UITableViewDataSource, MemoCellDelegate {
    
    @IBOutlet weak var memoListTableView: UITableView!
    
    var dataSource: [Memo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.memoListTableView.dataSource = self;
    
        let memo1 = Memo()
        memo1.memoId = "memo1"
        memo1.title = "週末の天気　強烈寒気で日本海側は大荒れ　太平洋側で積雪も"
        memo1.overview = "今週末は強烈な寒気の影響で、北陸から西日本の日本海側では広い範囲で大雪となる見込みだ。"
        memo1.detail = "26日（土）から27日（日）にかけては、上空に平年よりも6℃から12℃も気温の低い強い寒気が流れ込む。日本付近は強い冬型の気圧配置となるため、日本海側では広く大雪となり、太平洋側でも雪の降る所がありそうだ。特に26日は日本海側だけでなく、太平洋側の山地でも大雪となり、内陸部では平地も含め積雪となるおそれがある。週末の天気　強烈寒気で日本海側は大荒れ　太平洋側で積雪も26日午前10時の雨と風の予想今週末、特に雪の量が多くなりそうなのが北陸や関東甲信の山沿いで、丸2日間で最大で100センチ以上の雪が降る所がある見通し。大雪や路面の凍結による交通障害、電線や樹木への着雪、なだれに注意し、ビニールハウスなどの農業施設の被害にも併せて注意が必要となる。また、カーポートなどの簡易な建築物や老朽化している建築物などは倒壊のおそれがあるため、近寄らないようにしたい。"
        
        let memo2 = Memo()
        memo2.memoId = "memo2"
        memo2.title = "大坂なおみカツ丼食べたい"
        memo2.overview = "大雪や路面の凍結による交通障害、電線や樹木への着雪、なだれに注意し、ビニールハウスなどの農業施設の被害にも併せて注意が必要となる。また、カーポートなどの簡易な建築物や老朽化している建築物などは倒壊のおそれがあるため、近寄らないようにしたい。"
        memo2.detail = "メルボルン（オーストラリア）＝上田惇史】テニスの全豪オープン女子シングルスを制した大坂なおみ選手（２１）（日清食品）が優勝から一夜明けた２７日、メルボルン近郊で日本の報道陣の取材に応じた。カラフルなワンピース姿で登場した大坂選手は「今の気持ちはすごくうれしい。ちょっとなんかびっくりした」と日本語で心境を明かした。他のほとんどのやり取りは英語で行われた。大会を終えて食べたいものは「カツ丼、アゲイン」。昨年９月の全米オープン優勝時と同じメニューを挙げて笑いを誘った。優勝後に「血圧が上がった」と話した祖父の鉄夫さん（７４）へのメッセージを求められると「リラックスしてほしい」と頬を緩めた。"
        
        
        let memo3 = Memo()
        memo3.memoId = "memo3"
        memo3.title = "週末の天気　強烈寒気で日本海側は大荒れ　太平洋側で積雪も"
        memo3.overview = "26日（土）から27日（日）にかけては、上空に平年よりも6℃から12℃も気温の低い強い寒気が流れ込む。日本付近は強い冬型の気圧配置となるため、日本海側では広く大雪となり、太平洋側でも雪の降る所がありそうだ。"
        memo3.detail = "26日（土）から27日（日）にかけては、上空に平年よりも6℃から12℃も気温の低い強い寒気が流れ込む。日本付近は強い冬型の気圧配置となるため、日本海側では広く大雪となり、太平洋側でも雪の降る所がありそうだ。特に26日は日本海側だけでなく、太平洋側の山地でも大雪となり、内陸部では平地も含め積雪となるおそれがある。週末の天気　強烈寒気で日本海側は大荒れ　太平洋側で積雪も26日午前10時の雨と風の予想今週末、特に雪の量が多くなりそうなのが北陸や関東甲信の山沿いで、丸2日間で最大で100センチ以上の雪が降る所がある見通し。大雪や路面の凍結による交通障害、電線や樹木への着雪、なだれに注意し、ビニールハウスなどの農業施設の被害にも併せて注意が必要となる。また、カーポートなどの簡易な建築物や老朽化している建築物などは倒壊のおそれがあるため、近寄らないようにしたい。"
        
        let memo4 = Memo()
        memo4.memoId = "memo4"
        memo4.title = "週末の天気　強烈寒気で日本海側は大荒れ　太平洋側で積雪も"
        memo4.overview = "今週末は強烈な寒気の影響で、北陸から西日本の日本海側では広い範囲で大雪となる見込みだ。"
        memo4.detail = "26日（土）から27日（日）にかけては、上空に平年よりも6℃から12℃も気温の低い強い寒気が流れ込む。日本付近は強い冬型の気圧配置となるため、日本海側では広く大雪となり、太平洋側でも雪の降る所がありそうだ。特に26日は日本海側だけでなく、太平洋側の山地でも大雪となり、内陸部では平地も含め積雪となるおそれがある。週末の天気　強烈寒気で日本海側は大荒れ　太平洋側で積雪も26日午前10時の雨と風の予想今週末、特に雪の量が多くなりそうなのが北陸や関東甲信の山沿いで、丸2日間で最大で100センチ以上の雪が降る所がある見通し。大雪や路面の凍結による交通障害、電線や樹木への着雪、なだれに注意し、ビニールハウスなどの農業施設の被害にも併せて注意が必要となる。また、カーポートなどの簡易な建築物や老朽化している建築物などは倒壊のおそれがあるため、近寄らないようにしたい。"
        
        // Set datasource
        self.dataSource = [memo1, memo2, memo3, memo4]
    }
    
    // Tap on detail button
    func tappedOnDetail(memoId: String, memoCell: MemoCell) {
        memoCell.memoOverview.text = "26日（土）から27日（日）にかけては、上空に平年よりも6℃から12℃も気温の低い強い寒気が流れ込む。日本付近は強い冬型の気圧配置となるため、日本海側では広く大雪となり、太平洋側でも雪の降る所がありそうだ。特に26日は日本海側だけでなく、太平洋側の山地でも大雪となり、内陸部では平地も含め積雪となるおそれがある。週末の天気　強烈寒気で日本海側は大荒れ　太平洋側で積雪も26日午前10時の雨と風の予想今週末、特に雪の量が多くなりそうなのが北陸や関東甲信の山沿いで、丸2日間で最大で100センチ以上の雪が降る所がある見通し。大雪や路面の凍結による交通障害、電線や樹木への着雪、なだれに注意し、ビニールハウスなどの農業施設の被害にも併せて注意が必要となる。また、カーポートなどの簡易な建築物や老朽化している建築物などは倒壊のおそれがあるため、近寄らないようにしたい。"
        memoListTableView.beginUpdates()
        memoListTableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSource?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! MemoCell
       
        cell.delegate = self
        cell.selectionStyle = .none
        cell.memoId = self.dataSource![indexPath.row].memoId
        cell.memoOverview.text = self.dataSource![indexPath.row].overview
        cell.sizeToFit()
        
        return cell;
    }
}

