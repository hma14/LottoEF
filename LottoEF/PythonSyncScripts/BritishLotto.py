
import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re
from datetime import date
import DateTime

class BritishLotto(Lottotry):
	
	def __init__(self, tbl):
		super(BritishLotto, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://www.europeanlotteryguild.com/lottery_results/british_lotto_results")

		
		
	def searchDrawNumbers(self):
		numbers = []	
		driver = self.driver
		spans = driver.find_elements(By.CLASS_NAME, "ball")
		for span in spans[:7]:
			numbers.append(span.text)	
			
		print numbers
		return numbers
		

	def searchDrawDate(self):
		ps = []
		da = []
		driver = self.driver
		rows = driver.find_elements(By.XPATH, "//div[@class='row text-center']")	
		divs = rows[0].find_elements(By.TAG_NAME, "div")
		da = divs[0].text.split(' ')
		dat = self.dicDateShort[da[1]] + '-' + da[0] + '-' + str(date.today().year)

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

		(n1, n2, n3, n4, n5, n6, b) = self.searchDrawNumbers()

		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6), int(b)))
	
	
	def __delete__(self):
		self.driver.quit()
		self.dbClose()

def main():
	tblName = 'BritishLotto'
	lotto = BritishLotto(tblName)
			
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()
		
if __name__ == '__main__':
	main()
