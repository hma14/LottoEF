import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re


class FloridaLotto(Lottotry):

	def __init__(self, tbl):
		super(FloridaLotto, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://flalottery.com/lotto.do")


	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		spans = driver.find_elements(By.XPATH, "//div[@class='gamePageBalls']/p/span")
		for span in spans:
			num = span.get_attribute("title")
			if num != None and num.isdigit() == True:
				numbers.append(num)
				
		mb = driver.find_element(By.CLASS_NAME, "multiplier")
		numbers.append(mb.text[1])
			
		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		ps = driver.find_elements(By.XPATH, "//div[@class='gamePageNumbers']/p")
		txt = ps[1].text		
		txt = txt.replace(',', '')		
		lst = []
		lst = txt.split(' ')
		dat = self.dicDate[lst[1]] + '-' + lst[2] + '-' + lst[3]
			
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



def main():
	tblName = 'FloridaLotto'
	lotto = FloridaLotto(tblName)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()
	

if __name__ == '__main__':
	main()

	
