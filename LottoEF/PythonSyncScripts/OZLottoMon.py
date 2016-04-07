import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re
from datetime import datetime

class OZLottoMon(Lottotry):
	
	def __init__(self, tbl):
		super(OZLottoMon, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://www.ozlotteries.com/lotto-results#oz_lotto")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		results = driver.find_elements(By.CLASS_NAME, "result_block")
		for res in results:		
			draw = res.find_element(By.CLASS_NAME, "draw")
			
			if draw.text.find("Monday Lotto") == 0:
				print draw.text
				div = res.find_element(By.CLASS_NAME, "numbers")
				table = div.find_element(By.TAG_NAME, "table")
				trs = table.find_elements(By.TAG_NAME, "tr")
				tds = trs[1].find_elements(By.TAG_NAME, "td")	
				imgs = tds[0].find_elements(By.TAG_NAME, "img")
				for i in imgs:
					numbers.append(i.get_attribute("alt"))
					
				imgs = tds[1].find_elements(By.TAG_NAME, "img")
				for i in imgs:
					numbers.append(i.get_attribute("alt"))
				break
		
		return numbers
		

		

	def searchDrawDate(self):
		
		dat = ''
		driver = self.driver
		draws = driver.find_elements(By.CLASS_NAME, "draw")
		for d in draws:
			if d.text.find("Monday Lotto") == 0:
				arr = d.text.split()
				dat = self.dicDate[arr[6]] + '-' + arr[5][:-2] + '-' + arr[7]
				break
		
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
	tblName = 'OZLottoMon'
	lotto = OZLottoMon(tblName)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()

if __name__ == '__main__':
	main()

	
