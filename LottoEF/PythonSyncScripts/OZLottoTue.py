import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re


class OZLottoTue(Lottotry):
	
	def __init__(self, tbl):
		super(OZLottoTue, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://www.ozlotteries.com/lotto-results#oz_lotto")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		div1 = driver.find_element(By.CLASS_NAME, "result_8")
		div2 = div1.find_element(By.CLASS_NAME, "numbers")
		table = div2.find_element(By.TAG_NAME, "table")
		trs = table.find_elements(By.TAG_NAME, "tr")
		tds = trs[1].find_elements(By.TAG_NAME, "td")	
		imgs = tds[0].find_elements(By.TAG_NAME, "img")
		for i in range(7):
			numbers.append(imgs[i].get_attribute("alt"))
			
		imgs = tds[1].find_elements(By.TAG_NAME, "img")
		for i in range(2):
			numbers.append(imgs[i].get_attribute("alt"))
		
		print numbers
		return numbers
	

		

	def searchDrawDate(self):
		
		da = []
		driver = self.driver
		div = driver.find_element(By.CLASS_NAME, "result_8")
		txt = div.find_element(By.CLASS_NAME, "draw").text
		
		da = txt.split(' ')	
		dat =  self.dicDate[da[4]] + '-' + da[3][:-2] + '-' + da[5]
				
		return dat
	


	def dbInsert(self):

 		lastdate = self.dbLastDrawDate()
 		ddate = self.searchDrawDate()
 		if ddate == lastdate:
 			print ddate
 			print lastdate
 			print 'Already updated, skip'
 			return
	
		(n1, n2, n3, n4, n5, n6, n7, s1, s2) = self.searchDrawNumbers()
		
		dn = self.dbLastDrawNumber() + 1

		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d, %d, %d, %d)" % 
							(dn, ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6), int(n7), int(s1), int(s2)))
			


def main():
	tblName = 'OZLottoTue'
	lotto = OZLottoTue(tblName)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()

if __name__ == '__main__':
	main()

	
