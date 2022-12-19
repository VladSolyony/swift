//
//  ViewController.swift
//  Bingo
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    class BingoSheet {
        
        class BingoBox: CustomStringConvertible {
            
            var label = ""
            var checked = false
            var description: String { return self.label }
            
            init() {
                
                self.label = "blank"
                
            }
            
            init(_ label:String) {
                
                self.label = label
                
            }
            
            init(_ label:String, _ checked:Bool) {
                
                self.label = label
                self.checked = checked
                
            }
            
            func switchCheck(){
                
                self.checked = !self.checked

                
            }
            
            func setCheck(_ val:Bool){
                
                self.checked = val

                
            }
            
            func check() -> Bool {
                
                return self.checked
                
            }
            
            func relabel(_ label:String) {
                
                self.label = label
                
            }
            
        }
        
        var name:String = ""
        var sheet = [[BingoBox]]()
        
        init(_ name:String) {
            
            self.name = name
            
            for _ in 0...4 {
                var row = [BingoBox]()
                for _ in 0...4 {
                    row += [BingoBox()]
                }
                self.sheet += [row]
            }
            
        }
        
        func printSheet() {
            
            print(self.name + "'s Bingo Sheet:")
            for i in 0...4 {
                print(self.sheet[i][0], self.sheet[i][1], self.sheet[i][2], self.sheet[i][3], self.sheet[i][4], separator:"\t")
            }
            
        }
        
        func changeBox(_ i:Int, _ j:Int) -> Bool{
            
            self.sheet[i][j].switchCheck()
            return self.sheet[i][j].check()
            
        }
        
        func setBox(_ i:Int, _ j:Int, _ val:Bool) -> Bool{
            
            self.sheet[i][j].setCheck(val)
            return self.sheet[i][j].check()
            
        }
        
        func checkBox(_ i:Int, _ j:Int) -> Bool{
            
            return self.sheet[i][j].check()
            
        }
        
        func relabelBox(_ i:Int, _ j:Int, _ label:String) {
            
            self.sheet[i][j].relabel(label)
            
        }
        
        func checkBingo() -> Bool {
            
            return (self.checkHorizontal() || self.checkVertical() || self.checkDiagonal())
            
        }
        
        func checkHorizontal() -> Bool {
            
            for row in 0...4 {
                if (self.checkBox(row, 0) && self.checkBox(row, 1) && self.checkBox(row, 2) && self.checkBox(row, 3) && self.checkBox(row, 4)) {
                    return true
                }
            }
            return false
            
        }
        
        func checkVertical() -> Bool {
            
            for col in 0...4 {
                if (self.checkBox(0, col) && self.checkBox(1, col) && self.checkBox(2, col) && self.checkBox(3, col) && self.checkBox(4, col)) {
                    return true
                }
            }
            return false
            
        }
        
        func checkDiagonal() -> Bool {
            
            return ((self.checkBox(0, 0) && self.checkBox(1, 1) && self.checkBox(2, 2) && self.checkBox(3, 3) && checkBox(4, 4)) || (self.checkBox(0, 4) && self.checkBox(1, 3) && self.checkBox(2, 2) && checkBox(3, 1) && self.checkBox(4, 0)))
            
        }
        
    }

    @IBOutlet weak var aa: UIButton!
    @IBOutlet weak var ab: UIButton!
    @IBOutlet weak var ac: UIButton!
    @IBOutlet weak var ad: UIButton!
    @IBOutlet weak var ae: UIButton!
    @IBOutlet weak var ba: UIButton!
    @IBOutlet weak var bb: UIButton!
    @IBOutlet weak var bc: UIButton!
    @IBOutlet weak var bd: UIButton!
    @IBOutlet weak var be: UIButton!
    @IBOutlet weak var ca: UIButton!
    @IBOutlet weak var cb: UIButton!
    @IBOutlet weak var cc: UIButton!
    @IBOutlet weak var cd: UIButton!
    @IBOutlet weak var ce: UIButton!
    @IBOutlet weak var da: UIButton!
    @IBOutlet weak var db: UIButton!
    @IBOutlet weak var dc: UIButton!
    @IBOutlet weak var dd: UIButton!
    @IBOutlet weak var de: UIButton!
    @IBOutlet weak var ea: UIButton!
    @IBOutlet weak var eb: UIButton!
    @IBOutlet weak var ec: UIButton!
    @IBOutlet weak var ed: UIButton!
    @IBOutlet weak var ee: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var renameButton: UIButton!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var textReplaceButton: UIButton!
    @IBOutlet weak var statusText: UITextView!
    var bb1:BingoSheet = BingoSheet("Vlad")
    var buttons = [[UIButton]]()
    var buttonToRename = [UIButton]()
    var renameStuff:Bool!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.buttons = [[self.aa, self.ab, self.ac, self.ad, self.ae], [self.ba, self.bb, self.bc, self.bd, self.be], [self.ca, self.cb, self.cc, self.cd, self.ce], [self.da, self.db, self.dc, self.dd, self.de], [self.ea, self.eb, self.ec, self.ed, self.ee]]
        self.renameStuff = false
        self.valueField.isHidden = true
        self.textReplaceButton.isHidden = true
        self.statusText.text = ""
        
        self.valueField.delegate = self

    }
    
    @IBAction func pressed(_ sender: UIButton) {
        
        let coord = self.locateButton(sender)
        
        if (self.renameStuff) {
            self.buttonToRename = [sender]
        } else {
            let checked = self.bb1.changeBox(coord[0], coord[1])
            if (checked) {
                sender.backgroundColor = UIColor.lightGray
            } else {
                sender.backgroundColor = UIColor.clear
            }
            if (self.bb1.checkBingo()) {
                self.statusText.text = self.bb1.name + " got a bingo!"
            }
        }
        
    }
    
    @IBAction func replaceText(_ sender: UIButton) {
        
        if (self.valueField.text != "") {
            for currButton in self.buttonToRename {
                currButton.setTitle(self.valueField.text, for: UIControl.State.normal)
                self.valueField.text = ""
                self.statusText.text = "Renamed label."
            }
        }
        
    }
    
    @IBAction func renameBingoSwitch(_ sender: UIButton) {
        
        self.renameStuff = !self.renameStuff
        if (self.renameStuff) {
            sender.setTitle("Done", for: UIControl.State.normal)
            self.statusText.text = "Select an entry to rename."
            self.resetButton.isHidden = true
            self.valueField.isHidden = false
            self.textReplaceButton.isHidden = false
        } else {
            sender.setTitle("Rename Stuff", for: UIControl.State.normal)
            self.buttonToRename = []
            self.valueField.text = ""
            self.valueField.isHidden = true
            self.textReplaceButton.isHidden = true
            self.resetButton.isHidden = false
            self.view.endEditing(true)
        }
        
    }
    
    @IBAction func resetBingo(_ sender: UIButton) {
        
        var checked = false
        for i in 0...4 {
            for j in 0...4 {
                checked = self.bb1.setBox(i, j, false)
                if (checked) {
                    buttons[i][j].backgroundColor = UIColor.lightGray
                } else {
                    buttons[i][j].backgroundColor = UIColor.clear
                }
            }
        }
        self.statusText.text = "Bingo sheet cleared."
        
    }
    
    func locateButton(_ button: UIButton) -> [Int]{
        
        for i in 0...4 {
            for j in 0...4 {
                if (button == self.buttons[i][j]) {
                    return [i, j]
                }
            }
        }
        return [5, 5]
        
    }
    
    // прячет клавиатуру, когда нажимаем на окно вне ее
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    // прячет клавиатуру? когда пользователь
    // нажимает return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.valueField.resignFirstResponder()
        return true
        
    }
    
}
