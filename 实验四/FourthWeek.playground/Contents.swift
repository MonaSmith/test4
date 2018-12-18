//: Playground - noun: a place where people can play
import UIKit
import PlaygroundSupport

//第一题
let fileManager = FileManager.default
let  docPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.path

var file = docPath?.appending("/hrl")
if fileManager.fileExists(atPath: file!){
    let image = file?.appending("/pic.jpg")
    if fileManager.fileExists(atPath: image!){
        print("文件存在")
    }else{
        let url = URL(string: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1192412758,1563948098&fm=27&gp=0.jpg")
        let data = try Data(contentsOf: url!)
        try data.write(to: URL(fileURLWithPath: image!),options: .atomicWrite)
    }
}else{
    try fileManager.createDirectory(atPath: file!, withIntermediateDirectories: true, attributes: nil)
    print("文件不存在,请创建文件")
}


//第二与第三题
//自定义视图
class MyView:UIView{
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        //边框
        UIColor.green.setStroke()
        path.stroke()
        //填充
        UIColor.green.setFill()
        path.fill()
    }
}

class Controller:UIViewController{
    var label : UILabel!
    var circle : MyView!
    override func loadView() {
        view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 1000))
        view.backgroundColor = UIColor.red
        //创建圆
        let circle = MyView(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
        circle.backgroundColor = UIColor.clear
        view.addSubview(circle)
        label = UILabel(frame: CGRect(x: 100, y: 20, width: 200, height: 50))
        label.backgroundColor = UIColor.purple
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "Hello World!!!"
        view.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: 100, y: 550, width: 200, height: 50))
        button.backgroundColor = UIColor.blue
        button.setTitle("Click me", for: .normal)
        
        button.addTarget(self , action: #selector(Controller.clicked), for: .touchUpInside)
        view.addSubview(button)
        
    }
    @IBAction func clicked(){
        print("clicked successfully")
        label?.text = "clicked successfully"
        UIView.animate(withDuration: 1){
            self.circle.center = CGPoint(x: 200, y: 0)
        }
    }
}
let controllered = Controller()
PlaygroundPage.current.liveView = controllered
