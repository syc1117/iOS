//
//  ViewController.swift
//  ImagePickerControllerExample
//
//  Created by giftbot on 2020. 1. 4..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit
import MobileCoreServices

final class ViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView!
  private let imagePicker = UIImagePickerController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imagePicker.delegate = self // UIImagePickerControllerDelegate 채택한 후,UINavigationControllerDelegate를 같이 채택해야함. 이 둘이 묶여 있기 때문에 UIImagePickerControllerDelegate 하나만 하면 에러 발생함.
  }
  
  @IBAction private func pickImage(_ sender: Any) {
    print("\n---------- [ pickImage ] ----------\n")
    //imagePicker.sourceType: savedPhotosAlbum와 photoLibrary로 앨범모양 선택 가능
    //imagePicker.sourceType = .camera 를 사용하기 위해서는 카메라 유무 + info.plist 에서 Privacy - Camera Usage Description 추가 한 후 무슨 메시지 출력할지 오른쪽에 적어줘야 함. 안적으면 앱 배포시 에러남.
    imagePicker.sourceType = .savedPhotosAlbum
    present(imagePicker, animated: true)
  }
  
  
  @IBAction private func takePicture(_ sender: Any) {
    print("\n---------- [ takePicture ] ----------\n")
    
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
    imagePicker.sourceType = .camera
    //["public.image"]
    print(imagePicker.mediaTypes)
    
    //["public.image", "public.movie"] : public.movie 를 추가하면 동영상도 촬영이 됨.
    
    //아래 imagePicker.mediaTypes = [kUTTypeImage, kUTTypeMovie] as [String] 랑 같음.import MobileCoreServices를 사용하면 아래 코드 사용 불필요
    let mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)
    imagePicker.mediaTypes = mediaTypes ?? []
    //여기서 마이크 때문에 앱이 죽음
    
    //import MobileCoreServices를 사용하면 아래와 같이 kUTType을 사용할 수 있음.
    //imagePicker.mediaTypes = [kUTTypeImage, kUTTypeMovie] as [String]
//    imagePicker.mediaTypes = [kUTTypeImage] as [String]
    
    present(imagePicker, animated: true)
  }
  
  @IBAction private func takePictureWithDelay(_ sender: Any) {
    print("\n---------- [ takePictureWithDelay ] ----------\n")
    //몇 초후에 촬영
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
    imagePicker.sourceType = .camera
    imagePicker.mediaTypes = [kUTTypeImage as String]
    
    present(imagePicker, animated: true)
    
    //딜레이 촬영
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.imagePicker.takePicture()
    }
  }
    
  @IBAction private func recordingVideo(_ sender: Any) {
    print("\n---------- [ recordingVideo ] ----------\n")
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
    imagePicker.sourceType = .camera
    
    //kUTTypeMovie와 kUTTypeVideo의 차이 : kUTTypeMovie 소리포함, kUTTypeVideo  소리 미포함
    //소리를 위한 작업 필요: inpo.plist에서 Privacy - Microphone Usage Description 를 추가해줘야함.
    imagePicker.mediaTypes = [kUTTypeMovie as String]
    imagePicker.cameraCaptureMode = .video //동영상과 사진 둘다 취급할 경우에, 뭘 처음화면으로 띄울지 정하는 것
    imagePicker.videoQuality = .typeHigh //기본 값은 화질이 미디엄
    present(imagePicker, animated: true)
    imagePicker.cameraDevice = .front
    //동영상 촬영 시작 - 종료 설정 가능
//    imagePicker.startVideoCapture()
//    imagePicker.stopVideoCapture()
  }

  @IBAction private func toggleAllowsEditing(_ sender: Any) {
    print("\n---------- [ toggleAllowsEditing ] ----------\n")
    //didFinishPickingMediaWithInfo 에서 info[.editedImage] 를 사용해야함.
    //imagePicker.allowsEditing(편집기능)은 기본값이 false로 되어있음. 이를 toggle로 해주면 true가 됨.
    imagePicker.allowsEditing.toggle()
  }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //호출되는 시점: 사진촬영 혹은 갤러리에서 사진(동영상) 클릭했을 때
    //아래함수의 내용: 갤러리에서 이미지 선택했을 때 지정한 UIView에 해당 이미지를 넣고 카메라로 촬영한 이미지 및 동영상을 갤러리에 저장하는 것
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //info 파라미터에 사진이 들어옴.
        let mediaType = info[.mediaType] as! NSString
        if UTTypeEqual(mediaType, kUTTypeImage) {
            let originalImage = info[.originalImage] as! UIImage
            let editedImage = info[.editedImage] as? UIImage
            let selectedImage = editedImage ?? originalImage
            imageView.image = selectedImage
            //사진 저장하기: inpo.plist에 갤러리 추가 권한 획득 필요: Privacy - Photo Library Additions Usage Description
            if picker.sourceType == .camera { //이걸 안하면 앨범에서 확인할때마다 사진이 1개씩 늘어남.
            UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)//앨범에 저장하는 메서드
            }
            //영상 저장하기
        }else if UTTypeEqual(mediaType, kUTTypeMovie) {
            if let mediaPath = (info[.mediaURL] as? NSURL)?.path, //info로 들어온 동영상 객체의 URL에서 Path를 딴 후
                UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaPath) { //PhotosAlbum에 저장 가능한지 여부를 확인하고,
                UISaveVideoAtPathToSavedPhotosAlbum(mediaPath, nil, nil, nil)//저장한다.
            }
        }
        picker.dismiss(animated: true, completion: nil)
        //info의 정보를 꺼내서 활용. info[. ] 하면 .뒤에 어떤 것을 불러올 것인지를 선택. 직접 저장된 이미지를 가져올 것인지. url을 가져올 것인지 등.originalImage는 저장된 사진 불러오는 것.
//        let originalImage = info[.originalImage] as! UIImage
//        picker.dismiss(animated: true, completion: nil)
//        imageView.image = originalImage
    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          //취소 버튼 눌렀을 때 할 작업내용 코딩
//        //취소 버튼 눌렀을 때 할 작업이 없으면 이 함수 생략하면 됨.
//        picker.dismiss(animated: true, completion: nil)
//    }
}

