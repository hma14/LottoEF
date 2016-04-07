
import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re

class GermanLotto(Lottotry):
	
	def __init__(self, tbl):
		super(GermanLotto, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://www.lotto.net/german-lotto/results")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		row2 = driver.find_element(By.CLASS_NAME, "row-2")
		spans= row2.find_elements(By.TAG_NAME, "span")
		for span in spans:
			numbers.append(span.text)	
			
		print numbers[:-1]
		return numbers[:-1]
		

	def searchDrawDate(self):
		
		driver = self.driver
		dat = driver.find_element(By.CLASS_NAME, "date")
		str= dat.find_element(By.TAG_NAME, "span").text
		arr = str.split()
		da = arr[0]
		mo = arr[1][0] + arr[1][1:].lower()
		yr = arr[2]
	
		drawDate = self.dicDate[mo] + '-' + da + '-' + yr
		
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
		
		(n1, n2, n3, n4, n5, n6, b) = self.searchDrawNumbers()

		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6), int(b)))
	
	
	def __delete__(self):
		self.driver.quit()
		self.dbClose()

def main():
	tblName = 'GermanLotto'
	lotto = GermanLotto(tblName)
			
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()
		
if __name__ == '__main__':
	main()
