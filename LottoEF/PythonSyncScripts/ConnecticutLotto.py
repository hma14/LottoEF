'''
Created on Oct 18, 2013

@author: hma14
'''

from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
import datetime, time, re


class ConnecticutLotto(Lottotry):
    '''
    classdocs
    '''


    def __init__(self, tbl):
        '''
        Constructor
        '''
        
        super(ConnecticutLotto, self).__init__(tbl)
        self.driver.get("http://www.ctlottery.org/Modules/Games/default.aspx?id=6")
        
    def searchDrawDate(self):
        driver = self.driver
        ddate = driver.find_element(By.CLASS_NAME, "date").text
        arr = ddate.split()
        ddate = self.dicDate[arr[0]] + '/' + arr[1][:-1] + '/' + arr[2]
        return ddate
        
    def searchDrawNumbers(self):
        driver = self.driver
        numbers = list()
        cls = driver.find_element(By.CLASS_NAME, "p1")
        balls = cls.find_elements(By.CLASS_NAME, "ball")
        for ball in balls:
            numbers.append(ball.text)
        
        
        return numbers
    
    def dbInsert(self):
        dn = self.dbLastDrawNumber()
        ddate = self.searchDrawDate()
        lastdate = self.dbLastDrawDate()
        if ddate == lastdate:
            print ddate
            print lastdate
            print 'Already updated, skip'
            return
        
        dn += 1
        (n1, n2, n3, n4, n5, n6) = self.searchDrawNumbers()
        queryString = "insert into %s values(%d, '%s', %d, %d, %d, %d, %d, %d)" % (self.dbTable, dn, ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6))
        self.cursor.execute(queryString)
        
def main():
    tblName = 'ConnecticutLotto'
    lotto = ConnecticutLotto(tblName)
    lotto.dbInsert()
    lotto.dbClose()
    lotto.driver.close()
    lotto.driver.quit()
    
if __name__ == '__main__': main()