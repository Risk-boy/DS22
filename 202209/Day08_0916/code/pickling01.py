import pickle, MyScore
import zipfile

if __name__ == '__main__':
    f = open('pickle_01.txt', 'wb')
    s = [MyScore.Score('홍길동', 100, 100, 100),
         MyScore.Score('홍길동', 100, 100, 100),
         MyScore.Score('홍길동', 100, 100, 100)]
    pickle.dump(s, f)
    f = open('pickle_01.txt', 'rb')
    res = pickle.load(f)
    for r in res:
        print(r)

    # pickle_01.txt 파일을 my_shutil.zip 파일에 넣어보자
    # with zipfile.ZipFile('my_shutil.zip', 'a') as zf:
    #     zf.write('pickle_01.txt')

    # zip파일 안에 a.txt 파일 내용을 써보자
    # with zipfile.ZipFile('my_shutil.zip', 'a') as zf:
    #     with zf.open('a.txt', 'w') as f:
    #         f.write(b'abcdeg')

    # zip파일 안에 것들 출력
    with zipfile.ZipFile('my_shutil.zip', 'a') as zf:
        print(zf.namelist())