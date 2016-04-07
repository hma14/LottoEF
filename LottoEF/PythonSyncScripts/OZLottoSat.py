import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re
from datetime import datetime

class OZLottoSat(Lottotry):
	
	def __init__(self, tbl):
		super(OZLottoSat, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://tatts.com/nswlotteries/results/last-10-results?product=Saturday%20Lotto")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		tbl = driver.find_element(By.CLASS_NAME, "resultNumbersTbl")
		sub_tbls = tbl.find_elements(By.TAG_NAME, "table")
		
		divs = sub_tbls[0].find_elements(By.CLASS_NAME, "resultNumberWrapperDiv")
		for div in divs:
			span = div.find_element(By.CLASS_NAME, "resultNumberSpn")
			numbers.append(span.text)
		
		divs = sub_tbls[1].find_elements(By.CLASS_NAME, "resultNumberWrapperDiv")
		for div in divs:
			span = div.find_element(By.CLASS_NAME, "resultNumberSpn")	
			numbers.append(span.text)
		print numbers
		
		
		return numbers

		

	def searchDrawDate(self):
		
		dat = ''
		driver = self.driver
		span = driver.find_element(By.CLASS_NAME, "resultHeadingDrawDateSpn")
		arr = span.text.split()
		arr2 = arr[3].split('/')
		
		mo = self.dicDateShort[arr2[1]]
		da = arr2[0]
		yr = '20' + arr2[2].rstrip(',')
		dat = mo + '-' + da + '-' + yr
		print dat
		return dat
		
	


	def dbInsert(self):

		lastdate = self.dbLastDrawDate()		
		ddate = self.searchDrawDate()
		
		if ddate == lastdate:
			print ddate
			print lastdate
			print 'Already updated, skip'
			return
	
		(n1, n2, n3, n4, n5, n6, s1, s2) = self.searchDrawNumbers()
	
		dn = self.dbLastDrawNumber() + 1

		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d, %d, %d)" % 
							(dn, ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6), int(s1), int(s2)))
			


def main():
	tblName = 'OZLottoSat'
	lotto = OZLottoSat(tblName)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()

if __name__ == '__main__':
	main()

	
