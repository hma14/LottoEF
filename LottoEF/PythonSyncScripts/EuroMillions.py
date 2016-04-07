
# import re #RegEx library
# from urllib import urlopen
from Lottotry import Lottotry
# from selenium import webdriver
from selenium.webdriver.common.by import By
# from selenium.webdriver.support.ui import Select
# from selenium.common.exceptions import NoSuchElementException
# import unittest, time, re

	
class EuroMillions(Lottotry):
	
	def __init__(self, tbl, tbl2):
		super(EuroMillions, self).__init__(tbl)
		self.dbTable2 = tbl2
				
		driver = self.driver
		driver.get("http://www.euro-millions.com/results.asp")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		div = driver.find_element(By.CLASS_NAME, "latest-result")
		balls = div.find_elements(By.CLASS_NAME, "ball")
		for ball in balls:
			numbers.append(ball.text)
			
		stars = div.find_elements(By.CLASS_NAME, "lucky-star")
		for s in stars:
			numbers.append(s.text)

		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		div = driver.find_element(By.CLASS_NAME, "latest-result")
		d = div.find_element(By.CLASS_NAME, "date")
		arr = d.text.split()
		mo = self.dicDate[arr[2]]
		da = arr[1][:-2]
		yr = arr[3]
		drawDate = mo + "-" + da + "-" + yr
				
		print drawDate
		return drawDate


	def convertDate(self):
		dat = self.searchDrawDate()
		da = dat.split(' ')
		day = da[1]		
		dat = str(self.dicDate[da[2]]) + '-' + str(day[:2]) + '-' + str(da[3])
			
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
		(n1, n2, n3, n4, n5, s1, s2) = self.searchDrawNumbers()

		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5)))
			
		self.cursor.execute("insert into " + self.dbTable2 + " VALUES(%d, '%s', %d, %d)" % 
							(int(dn), ddate, int(s1), int(s2)))



def main():
	tblName = 'EuroMillions'
	tblName2 = 'EuroMillions_LuckyStars'
	lotto = EuroMillions(tblName, tblName2)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.updateXMLFile(tblName2)
	lotto.driver.close()
	lotto.driver.quit()
	
if __name__ == '__main__':
	main()

	
