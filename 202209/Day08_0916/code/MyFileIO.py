# 나만의 모듈을 만들자
import dataclasses

@dataclasses.dataclass
class MyFile:
    __file : str = ''

    def file_write(self):
        with open(self.__file, 'w') as f:
            for i in range(1, 10):
                for j in range(1, 10):
                    f.write(f'{i} * {j} = {i * j}\n')

    def file_read(self):
        # with문 사용
        with open(self.__file, 'r') as f:
            print(f.read())

    def file_write02(self):
        with open(self.__file, 'wb') as f:
            # for i in range(1, 10):
            #     for j in range(1, 10):
            #         f.write(f'{i} * {j} = {i * j}\n')
            for i in range(1, 10):
                f.write(b'abc123')
# 파일을 오픈할 때 b모드로 쓰거나 읽으면 type이 bytes가 된다
# read(bytes size)는 str을 return 하겠지만 open mode에 b를 지정하게 되면 bytes로 읽는다.
    def file_read02(self):
        # while문
        try:
            f = open(self.__file, 'r+b')
            while True:
                s = f.read(1)
                if s == b'':
                    break
                else:
                    print(s.hex())  # hex()는 s가 문자열이기 때문에 s.hex()로 호출
                    print(type(s))
            f.close()
        except IOError as e:
            print(e)


if __name__ == '__main__':
    r = MyFile('b.txt')
    r.file_write02()
    r.file_read02()