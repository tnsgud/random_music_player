import firebase
import download

choice = input("할 작업을 선택해주세요.\n1:파일 다운로드/2:데이터 업로드/3:텍스트파일 수정 : ")

if choice == '1':
    download.youtubeDownload(download.parseText(
        download.readFile("./musics.txt")))
elif choice == '2':
    firebase.setData(firebase.parseText(
        firebase.readFile("./musics.txt")), firebase.startFirebase())
elif choice == '3':
    check = input("musicx.txt파일을 변경할것 입니까? (Y/n): ")
    if check == "y" or check == 'Y':
        title = input("변경할 노래의 제목 : ")
        url = input("변경할 노래의 주소 : ")
        genres = input("변경할 노래의 장르 : ")
        firebase.writeFile('./musics.txt', title, url, genres=genres)
    elif check == 'N' or check == 'n':
        path = input('변경할 파일의 경로를 써주세요. : ')
        title = input("변경할 노래의 제목 : ")
        url = input("변경할 노래의 주소 : ")
        genres = input("변경할 노래의 장르 : ")
        firebase.writeFile(path, title, url, genres=genres)
