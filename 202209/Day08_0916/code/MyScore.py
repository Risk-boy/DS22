# 세 과목을 관리하는 Class
class Score:
    # 변수자리
    # __name = 'noname'
    # __k = 0
    # __e = 0
    # __m = 0
    # 생성자에서 초기값 처리
    def __init__(self, name, k, e, m):
        self.__name = name
        self.__k = k
        self.__e = e
        self.__m = m

    def getName(self):
        return self.__name

    def getTot(self):
        return self.__k + self.__e + self.__m

    def getAvg(self):
        return round(self.getTot() / 3, 2)

    def getGrade(self):
        avg = self.getAvg()
        if avg >= 80:
            return 'A'
        elif avg >= 70:
            return 'B'
        else:
            return 'C'

    # 국어 수학 영어 값을 리턴하는 Method
    def getKor(self):
        return self.__k

    def getMat(self):
        return self.__m

    def getEng(self):
        return self.__e

    def setName(self, name):
        self.__name = name
    # 국어 수학 영어 과목을 값전달 및 변경
    def setKor(self, kor):
        self.__k = kor

    def setMat(self, mat):
        self.__m = mat

    def setEng(self, eng):
        self.__e = eng

    # def myPrn(self):
    #     print(f'{self.getName()} {self.getKor()} '
    #           f'{self.getMat()} {self.getEng()} '
    #           f'{self.getTot()} {self.getAvg()} '
    #           f'{self.getGrade()}')

    # 선조가 가진 method를 재정의 한다.
    def __str__(self):
        return f'{self.__name} {self.__k} '\
              f'{self.__e} {self.__m} {self.getTot()} '\
              f'{self.getAvg()} {self.getGrade()}'

# class MyTest:
#     def __str__(self):
#         return '내꺼야'

