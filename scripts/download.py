import youtube_dl
import os

def youtubeDownload(url: str, name:str):
    # 실행되는 폴더 안에 '영상제목.확장자' 형식으로 다운로드
    if name == '':
        output_dir = os.path.join('./music/', '%(title)s.mp3')
    elif name != '':
        output_dir = os.path.join('./music/', f'{name}.mp3')

    # 여러 영상을 받을 수 있고 플레이리스트도 가능함
    download_list = [
        url
    ]

    ydl_opt = {
        'outtmpl': output_dir,
        'format': 'bestaudio/best',  # 최상 품질의 비디오 형식 선택
    }

    with youtube_dl.YoutubeDL(ydl_opt) as ydl:
        ydl.download(download_list)

    print(f"{url} 다운로드 완료했습니다.")

url = input("다운 받을 노래의 url를 쓰세요. : ")
choice = input("파일의 이름을 변경하실건가요? (Y/n) :")
if choice == 'Y' or choice == 'y':
    name = input('변경할 이름을 써주세요. : ')
    youtubeDownload(url, name=name)
elif choice == 'n' or choice == 'N':
    youtubeDownload(url, '')
