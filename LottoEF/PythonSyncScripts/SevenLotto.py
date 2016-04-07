
import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re


class SevenLotto(Lottotry):
	
	def __init__(self, tbl):
		super(SevenLotto, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://www.zhcw.com/kaijiang/zhcw_qlc_index.html")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		lis = driver.find_elements(By.XPATH, "//li[@class='red']")
		for li in lis:
			numbers.append(li.text)	

		li = driver.find_element(By.XPATH, "//li[@class='blue']")
		numbers.append(li.text)
		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		dat = driver.find_element(By.TAG_NAME, "span")
		print dat.text
				
		return dat.text


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
		(n1, n2, n3, n4, n5, n6, n7, b) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6), int(n7), int(b)))



def main():
	tblName = 'SevenLotto'
	lotto = SevenLotto(tblName)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)	
	lotto.driver.close()
	lotto.driver.quit()

if __name__ == '__main__':
	main()

	
