import youtube_dl
import os


def readFile(path: str):
    """
    파일을 읽어 내용을 반환하는 메소드
    """
    file = open(path, 'r')
    res = []
    line = file.readline()
    while line:
        res.append(line)
        line = file.readline()
    file.close()
    return res


def mkdic(title: str, singer: str, url: str, genres: list):
    """
    Dictionary를 만드는 메소드
    """
    res = {
        "title": title,
        "singer": singer,
        "genres": genres,
        "url": url
    }
    print(res)
    return res


def parseText(string: list):
    """
    Cloud store 형식에 맞게 텍스트를 나누는 메소드
    """
    res = []
    for i in range(0, len(string)):
        a = string[i].split(" - ")
        b = a[3].split(":")
        res.append(mkdic(a[0], a[1], a[2], b))
    return res


def youtubeDownload(dic: dict):
    # 실행되는 폴더 안에 '영상제목.확장자' 형식으로 다운로드

    output_dir = os.path.join('./music/', f'{dic[0]["title"]}s.mp3')
    url = f"{dic[0]['url']}"
    # 여러 영상을 받을 수 있고 플레이리스트도 가능함
    download_list = [
        url
    ]

    ydl_opt = {
        'outtmpl': output_dir,
        'format': 'bestaudio/best',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }]
    }

    with youtube_dl.YoutubeDL(ydl_opt) as ydl:
        ydl.download(download_list)

    print(f"{url} 다운로드 완료했습니다.")

# url = input("다운 받을 노래의 url를 쓰세요. : ")
# choice = input("파일의 이름을 변경하실건가요? (Y/n) :")
# if choice == 'Y' or choice == 'y':
#     name = input('변경할 이름을 써주세요. : ')
#     youtubeDownload(url, name=name)
# elif choice == 'n' or choice == 'N':
#     youtubeDownload(url, '')
