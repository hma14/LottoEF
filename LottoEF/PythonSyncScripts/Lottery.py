
import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re

class Lottery(Lottotry):
	
	def __init__(self, tbl):
		super(Lottery, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://lotto.bclc.com/winning-numbers/lotto-649-and-extra.html")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		lis = driver.find_elements(By.XPATH, "//ul[@class='list-items']/li")
		for li in lis:
			numbers.append(li.text)	

		numbers[6] = numbers[6].replace('Bonus', '')
		numbers[6] = numbers[6].lstrip()
		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		dat = driver.find_element(By.CLASS_NAME, "date")
		
		arr = dat.text.split()
		da = self.dicDateShort2[arr[0]] + '-' + arr[1][:-1] + '-' + arr[2]
		print da
				
		return da



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
	tblName = 'Lottery'
	lotto = Lottery(tblName)
			
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()
	
		
if __name__ == '__main__':
	main()
