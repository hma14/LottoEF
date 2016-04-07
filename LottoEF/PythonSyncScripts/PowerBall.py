
import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re

class PowerBall(Lottotry):
	
	def __init__(self, tbl, tbl2):
		super(PowerBall, self).__init__(tbl)
		self.dbTable2 = tbl2
				
		driver = self.driver
		driver.get("http://www.powerball.com/powerball/pb_numbers.asp")
		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		
		tbl = driver.find_element(By.XPATH, "//table[@align='center']")
		trs = tbl.find_elements(By.TAG_NAME, "tr")
		tds = trs[1].find_elements(By.TAG_NAME, "td")
		i = 1
		for i in range(1, 8):
			if i == 6:
				continue
			numbers.append(tds[i].text)
		
		print numbers

			
		return numbers
		

	def searchDrawDate(self):
		
		dat = None
		lst = []
		driver = self.driver
		
		tbl = driver.find_element(By.XPATH, "//table[@align='center']")
		trs = tbl.find_elements(By.TAG_NAME, "tr")
		tds = trs[1].find_elements(By.TAG_NAME, "td")
		dat = tds[0].text					
		print dat			
		return dat


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
		(n1, n2, n3, n4, n5, b) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5)))
		self.cursor.execute("insert into " + self.dbTable2 + " VALUES(%d, '%s', %d)" % 
							(int(dn), ddate, int(b)))
			


def main():
	tblName = 'PowerBall'
	tblName2 = 'PowerBall_PowerBall'
	lotto = PowerBall(tblName, tblName2)

	lotto.dbInsert()
	#lotto.dbSelectAll()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.updateXMLFile(tblName2)
	lotto.driver.close()
	lotto.driver.quit()

if __name__ == '__main__':
	main()

	
