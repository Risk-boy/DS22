f = open("test.txt", "r") # 파일의 객체를 오픈한다

str = f.read()  # 전체 파일을 읽어서 리턴
print(str)     # a~z까지 출력한다

# seek(offset, [whence])
# whence = 0: 기준이 처음부터 ex) seek(10, 0): 앞에서부터 10번째 부터
# whence = 1: 현재 위치부터    ex) seek(10, 1): 현재위치부터 10번째 부터
# whence = 2: 기준이 끝에서부터  ex) seek(10, 2): 끝에서부터 10번째부터
# tell(): 파일에서 현재 위치 return
f.seek(0)      # 파일 포인터의 위치를 0으로 이동
while(1):      # 더이상 읽어들일 파일이 없을 때까지 루프를 돈다
     l = f.readline()         # 한줄씩 읽어서
     if(l):                   # 읽어낸 line이 있는 경우
          print(l)            # 출력한다
     else:
          break
# 파일을 다 읽고 나서 포인터가 마지막에 놓여 있어 포인터의 위치를 0으로 이동한다
f.seek(0)

# 한줄씩 읽어서 리스트 객체로 줄 바꿈 \n 이 표시되어 리턴
ls = f.readlines()

print(ls) # 출력한다  -> ['abcdefg\n', 'hijklmn\n', 'opqrstu\n', 'vwxyz']
print(ls[3][2])   # 세번째 줄의 index 가 2인 문자를 출력한다
# readlines() 는 모든 line을 한 번에 읽어오므로
# 파일의 마지막 위치를 print 하게 된다
print(f.tell())

f.close()

