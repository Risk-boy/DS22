import zipfile  # 파일 읽고 쓸 때 함께 사용하는 모듈

#1. 파일을 생성해서 데이터를 쓰고 읽어보자 / open(파일명, w/r/a/b)
# open(파일명, [w+])
def file_Test():
    f = open('a.txt', 'w')
    # a+ : 계속 append
    for i in range(65, 91):
        f.write('%3s' %chr(i))
    f.close()   # 열었으면 닫아주기

    f = open('a.txt', 'r')
    # print(f.read(10))   # 10개의 bytes만 읽어옴(공백도 bytes에 포함)
    print(f.read())
    f.close()
    print('-'*50)
    f = open('apple.jpg', 'r+b')
    print(f.read())
    f.close()


def file_Test01():
    # apple.jpg의 내용을 읽어서 apple02.png로 출력
    f = open('apple.jpg', 'r+b')
    f_o = open('apple02.jpg', 'w+b')
    f_o.write(f.read())
    f_o.close()
    f.close

def file_Test02():
    # with as 문을 이용해서 파일을 입출력 해보자
    with open('apple.jpg', 'r+b') as f:
        print(f.read())
    # 자동으로 close 해줌

def file_Test03():
    # 구구단 출력하고 읽어 오자
    with open('gugu.txt', 'w') as f:
        for i in range(1, 10):
            f.write(f'{2} * {i} = {2*i}\n')
    with open('gugu.txt', 'r') as f:
        print(f.readlines())

def file_Test04():
    pass

def file_Test05():
    pass


if __name__ == '__main__':
    file_Test03()