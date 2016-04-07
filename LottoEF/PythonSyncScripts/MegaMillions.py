import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re

class MegaMillions(Lottotry):
	
	def __init__(self, tbl, tbl2):
		super(MegaMillions, self).__init__(tbl)
		self.dbTable2 = tbl2
				
		driver = self.driver
		driver.get("http://www.megamillions.com/winning-numbers")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		divs = driver.find_elements(By.CLASS_NAME, "winning-numbers-white-ball")
		
		for div in divs:
			numbers.append(div.text)
		
		div = driver.find_element(By.CLASS_NAME, "winning-numbers-mega-ball")
		numbers.append(div.text)
		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		dat = driver.find_element(By.TAG_NAME, "h1")
		match = re.search(r'(\d+/\d+/\d{4})', dat.text)
		dat = match.group(1)
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
	tblName = 'MegaMillions'
	tblName2 = 'MegaMillions_MegaBall'
	lotto = MegaMillions(tblName, tblName2)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.updateXMLFile(tblName2)
	lotto.driver.close()
	lotto.driver.quit()

if __name__ == '__main__':
	main()

	
