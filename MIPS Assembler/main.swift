import Foundation


//
func main(){
    print("1. To live code\n2. To read from text")
    guard let input = readLine() else {return}
    if input == "1"{
        interpertation()
    }
    else{
        readingFile(fileName: "instructions")
    }
}


main()
//
