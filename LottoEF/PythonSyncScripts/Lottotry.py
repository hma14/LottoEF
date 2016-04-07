'''
Created on 2012-07-08

@author: WebServer
'''

# import re #RegEx library
import pyodbc
import datetime

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re


class Stack:
    def __init__(self):
        self.__storage = []

    def isEmpty(self):
        return len(self.__storage) == 0

    def push(self, p):
        self.__storage.append(p)

    def pop(self):
        return self.__storage.pop()
    

class Lottotry(object):
    '''
    classdocs
    '''

    dbTable = ''
    dbConnection = ''
    cursor = ''
    
    
    dicLotto = {
                "Lottery":0, "LottoMax":1, "BC49":2, "FloridaLotto":3,
                "MegaMillions":4, "MegaMillions_MegaBall":5,
                "PowerBall":6, "PowerBall_PowerBall":7,
                "NYLotto":8, "EuroMillions":9, "EuroMillions_LuckyStars":10,
                "OZLottoTue":11, "SSQ":12, "SSQ_Blue":13, "SevenLotto":14,
                "SuperLotto":15, "SuperLotto_Rear":16,
                "NYSweetMillion":17, "ColoradoLotto":18, 
                "FloridaLucky":19, "EuroJackpot":20, "EuroJackpot_Euros":21, 
                "GermanLotto":22, "BritishLotto":23, "OZLottoSat":24,
                "FloridaFantasy5":25, "OZLottoMon":26, "OZLottoWed":27,
                "ConnecticutLotto":28, "CaSuperlottoPlus":29,"CaSuperlottoPlus_Mega":30,
                "NewJerseyPick6Lotto":31, "OregonMegabucks":32
    }
    
    dicDate = {
               "January":"01", "February":"02", "March":"03", "April":"04", "May":"05",
               "June":"06", "July":"07", "August":"08", "September":"09", "October":"10",
               "November":"11", "December":"12" 
    }       
    
    dicDateShort = {
                     "Jan":"01", "Feb":"02", "Mar":"03", "Apr":"04", "May":"05",
                     "Jun":"06", "Jul":"07", "Aug":"08", "Sep":"09", "Oct":"10",
                     "Nov":"11", "Dec":"12" 
    }
    dicDateShort2 = {
                     "JAN":"01", "FEB":"02", "MAR":"03", "APR":"04", "MAY":"05",
                     "JUN":"06", "JUL":"07", "AUG":"08", "SEP":"09", "OCT":"10",
                     "NOV":"11", "DEC":"12" 
    }
       
        
        
    def __init__(self, tbl):
        
        '''
        Constructor
        '''
        self.dbConnection = pyodbc.connect(r"DRIVER={SQL Server};SERVER=WEBSERVER-PC\SQLSERVER2014;DATABASE=lottoEF;UID=sa;PWD=Hma@1985",
                                           autocommit=True)

        self.dbTable = tbl
        self.cursor = self.dbConnection.cursor()
        #self.driver = webdriver.Firefox()
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(30)
#        self.base_url = "http://lotto.bclc.com"

        
        
    def dbSelectAll(self):
        self.cursor.execute("select * from " + self.dbTable)
        rows = self.cursor.fetchall()
        for row in rows:
            print row

    '''
    Call stored procedures in lottotry
    '''
    def dbLastDrawNumber(self):
        print(self.dicLotto[self.dbTable])
        self.cursor.execute("{call GetLastRow(?)}", (self.dicLotto[self.dbTable]))
        drawnum = self.cursor.fetchone()

        return drawnum[0]

    '''
    Call stored procedures in lottotry
    '''
    def dbLastDrawDate(self):
        self.cursor.execute("{call GetLastDrawDate(?)}", (self.dicLotto[self.dbTable]))
        drawdate = self.cursor.fetchone()

        #print drawdate[0], 
        return drawdate[0]
    
    def convertDate(self):

        dat = self.searchDrawDate()
        dat = re.sub(r',', '', dat)   
        lst = dat.split()
        if self.dbTable == 'LottoMax':
            dat = str(lst[2]) + '-' + self.dicDateShort2[lst[0]] + '-' + str(lst[1])
        else:
            dat = str(lst[2]) + '-' + self.dicDateShort[lst[0]] + '-' + str(lst[1])
        
        return dat
                 
    def convertDateText(self, dateText):
        
        dat = re.sub(r',', '', dateText)   
        lst = dat.split(' ')
        if self.dbTable == 'LottoMax':
            dat = str(lst[2]) + '-' + self.dicDateShort2[lst[0]] + '-' + str(lst[1])
        else:
            dat = self.dicDateShort[lst[0]] + '-' + str(lst[1]  + '-' + str(lst[2]))
        
        return dat
                 
     
    def dbClose(self):
        self.dbConnection.close()
        

    def updateXMLFile(self, tblName):
        outFile = open(r'F:\lottotry\XML\%s.xml' % tblName, 'a')
        now = datetime.datetime.now()
        now = str(now) + '\n'
        outFile.writelines(now)
        outFile.close()
        
    def removeMultipleSpaces(self):
        infile = open("%s.txt" % self.dbTable, "r")
        outfile = open("tmp.txt", "w")
        for line in infile.readlines():
            line = re.sub(r'(\s+)', ' ', line)
            outfile.write(line + "\n")

        infile.close()
        outfile.close()

