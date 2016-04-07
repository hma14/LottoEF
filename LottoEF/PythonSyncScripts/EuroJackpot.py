
import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re

	
class EuroJackpot(Lottotry):
	
	def __init__(self, tbl, tbl2):
		super(EuroJackpot, self).__init__(tbl)
		self.dbTable2 = tbl2
				
		driver = self.driver
		driver.get("http://www.euro-millions.com/eurojackpot-results.asp")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		div = driver.find_element(By.CLASS_NAME, "latest-result-euro")	
		ul = div.find_element(By.CLASS_NAME, "jack-balls")
		balls = ul.find_elements(By.CLASS_NAME, "jack-ball")
		for b in balls:
			numbers.append(b.text)
			
		euros = ul.find_elements(By.CLASS_NAME, "jack-euro")
		for e in euros:
			numbers.append(e.text)
			
# 		tbls = driver.find_elements(By.TAG_NAME, "table")
# 		trs = tbls[1].find_elements(By.TAG_NAME, "tr")		
# 		balls = trs[0].find_elements(By.CLASS_NAME, "jack-ball")
# 		for b in balls:
# 			numbers.append(b.text)	
# 
# 		stars = trs[0].find_elements(By.CLASS_NAME, "jack-euro")
# 		for s in stars:
# 			numbers.append(s.text)	

		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		div = driver.find_element(By.CLASS_NAME, "latest-result-euro")
		
		dat = div.find_element(By.CLASS_NAME, "date")	
		arr = dat.text.split()
		day = arr[1][:-2]
		mon = self.dicDate[ arr[2] ]
		yr = arr[3]
		
		drawDate = mon + '-' + day + '-' + yr
		
		print drawDate
		return drawDate


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
		(n1, n2, n3, n4, n5, e1, e2) = self.searchDrawNumbers()

		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5)))
			
		self.cursor.execute("insert into " + self.dbTable2 + " VALUES(%d, '%s', %d, %d)" % 
							(int(dn), ddate, int(e1), int(e2)))



def main():
	tblName = 'EuroJackpot'
	tblName2 = 'EuroJackpot_Euros'
	lotto = EuroJackpot(tblName, tblName2)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.updateXMLFile(tblName2)
	lotto.driver.close()
	lotto.driver.quit()
	
if __name__ == '__main__':
	main()

	
