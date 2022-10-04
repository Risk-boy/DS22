import os, glob
import shutil
import time
import zipfile  # 파일 읽고 쓸 때 함께 사용하는 모듈

#1. 작업경로를 리턴해보자
def Test01():
    # 현재 디렉토리 경로를 탐색해보자
    # res = os.access(".", os.R_OK | os.W_OK | os.X_OK)
    res = os.access(os.getcwd(), os.R_OK | os.W_OK | os.X_OK)
    print(res)
    print('현재 디렉토리 리턴: ', os.getcwd())
    print('디렉토리 변경')
    os.chdir('c:\Temp')
    print('현재 디렉토리 리턴: ', os.getcwd())

#2. 디렉토리 탐색을 해보자
def Test02():
    for dirpath, dirnames, filenames in os.walk(r'C:\Users\user\AppData\Local\Programs\Python\Python310', topdown=False):
        print(dirpath, dirnames, filenames)

#3. 디렉토리를 작성해보자 makedir(), makedirs, rmdir(), removedirs()
def Test03():   # 두번 실행 -> FileExistsError
    print('c:\m 폴더를 만들자')
    try:
        os.makedirs('c:\m', mode=os.W_OK)
        # 디렉토리 삭제해보자
        # os.rmdir('c:\m')
        # c:\a\b\c\d\e 폴더를 만들어보자
        # os.makedirs(r'c:\a\b\c\d\e', mode=os.W_OK)
        # os.removedirs(r'c:\a\b\c\d')
        # os.rmdir(r'c:\a')
    except FileExistsError as e:
        print('이미 폴더 만들었당~~')

#4. os.path로 지정된 경로를 time모듈을 통해 생성, 탐색한 날짜를 확인해보자
# 지정된 디렉토리의 파일을 추려서 작업을 하다가 풀경로를 만들고 싶다
def Test04():
    print('목록확인')
    print(os.listdir(r'c:\\'))
    # path = os.curdir        # path = '.'
    path = r'C:\Users\user\Desktop\MLP\pjt_0907\code'
    file_list = os.listdir(path)    # listdir은 풀경로를 return하지 않는다
    for file in file_list:          # 파일명만 추출
        file_fullname = os.path.join(path, file)    # path, filename 결합!! 중요!!
        # print(file_fullname, os.stat(file_fullname))
        print(file_fullname, os.stat(file_fullname).st_size, time.ctime(os.stat(file_fullname).st_mtime))

#5. full path를 separate / os.path, basename(), split() -> tuple로 return
# normpath()를 사용 (os 상관없음)
# splitext()
def Test05():
    file = r'C:\Users\user\Desktop\MLP\pjt_0907\code\case01.py'
    if os.path.isfile(file):    # 괄호 안의 대상이 파일인지를 True, False로 return
        a = os.path.basename(file)  # 파일 이름만 return
        print(a)
        b = os.path.normpath(file)  # 파일 full path return
        print(b)
        split_b = os.path.split(file)   # path, file_name 분리, tuple로 return
        print(split_b)
        # split_file = os.path.split(file)
        # print(split_file)
        c = os.path.splitext(file)      # (경로 + 파일명, 확장자명)
        print(c)

def Test06():
    file = r'C:\Users\user\Desktop\MLP\pjt_0907\code\case01.py'
    print((os.path.getsize(file)))
    print(time.ctime(os.path.getmtime(file)))
    print(time.ctime(os.path.getatime(file)))
    print(time.ctime(os.path.getctime(file)))

# glob: os.path에서 부족한 점을 채워줌
# 파일 및 디렉토리에 대한 path 필터를 정규식으로 mapping
def Test07():
    path = r'C:\Users\user\Desktop\MLP\pjt_0907\code'
    print(path)
    print(glob.glob(path + '/*.py')) # 목록으로 경로와 함께 return 된다.
                                    # print(glob.glob('*.txt'))

# glob를 이용한 패턴에 대한 path를 활용해 보자
def Test08():
    # Test 하위에서 모든내용을 추출해보자
    print(glob.glob('C:\Test\Test\*'))

    # Test 하위에서 txt 확장자만 추출
    print(glob.glob('C:\Test\Test\*.txt'))

    # Test 하위에 디렉토리 확장자 txt만 추출
    print(glob.glob('C:\Test\Test\*\*.txt'))

    # Test\dir\ 하위에 디렉토리 확장자 txt만 추출
    print(glob.glob('C:\Test\Test\dir\*\*.txt'))

    # Test\ 하위에 한글자 이름을 갖는 txt파일 추출
    print(glob.glob('C:\Test\Test\?.txt'))

    # Test\ 하위에 소문자 a-z 까지로 시작되는 파일 추출(한글자)
    print(glob.glob('c:\Test\Test\[a-z].txt'))

    # Test\ 하위에 소문자 0-9 까지로 시작되는 파일 추출
    print(glob.glob('c:\Test\Test\[0-9]*.txt'))

    # Test\하위에 전체를 추출
    print(glob.glob('c:\Test\Test\**', recursive=True))

    # *는 두개까지만 효과
    print(glob.glob('c:\Test\Test\***', recursive=True))

# isdir, isfile
def Test09():
    # 전체 추출하자
    print([f for f in glob.glob('c:\Test\**', recursive=True) if os.path.isfile(f)])

    # 파일 이름만 추출
    print([os.path.basename(f) for f in glob.glob('c:\Test\**', recursive=True) if os.path.isfile(f)])

    # 디렉토리 이름만 추출
    print([os.path.basename(f) for f in glob.glob('c:\Test\**', recursive=True) if os.path.isdir(f)])


def Test10():
    # import shutil
    # archive: 압축파일 만들기
    shutil.make_archive('my_shutil02', format='zip', root_dir='.', base_dir='c:\Test')
    shutil.unpack_archive('my_shutil02.zip', 'def')

# Test02와 08 비교
if __name__ == '__main__':
    # 크롤링된 파일을 디렉토리에 목적별로 저장하고, 조건에 따라 추출할 경우 사용한다.
    Test10()
