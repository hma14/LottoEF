import re #RegEx library
from urllib import urlopen
from Lottotry import Lottotry
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re

class NYSweetMillion(Lottotry):
	
	def __init__(self, tbl):
		super(NYSweetMillion, self).__init__(tbl)
				
		driver = self.driver
		driver.get("http://nylottery.ny.gov/wps/portal/!ut/p/c5/04_SB8K8xLLM9MSSzPy8xBz9CP0os_jggBC3kDBPE0MLC0dnA09vT0fLQDNvA0dfU30_j_zcVP2CbEdFACF_Djk!/dl3/d3/L0lDU0lKSWdrbUEhIS9JRFJBQUlpQ2dBek15cXchLzRCRWo4bzBGbEdpdC1iWHBBRUEhLzdfU1BURlRWSTQxODhBQzBJS0lBOVE2SzBRUzAvVnBlcHEzNTIwMDA4MA!!/?PC_7_SPTFTVI4188AC0IKIA9Q6K0QS0_WCM_CONTEXT=/wps/wcm/connect/NYSL+Content+Library/NYSL+Internet+Site/Home/Jackpot+Games/SWEET+MILLION/")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		divs = driver.find_elements(By.CLASS_NAME, "WinningNumbersResultsSweetMillion")
		for div in divs:
			numbers.append(div.text)
			
		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		dat = driver.find_element(By.CLASS_NAME, "WinningNumbersText")
		print dat.text
				
		dat = self.convertDateText(dat.text)
		return dat	
		


	def dbInsert(self):

		dn = self.dbLastDrawNumber()
		ddate = self.searchDrawDate()
		lastdate = self.dbLastDrawDate()

		if ddate == lastdate:
			print ddate
			print lastdate
			print 'Alread updated, skip'
			return

		dn += 1
		(n1, n2, n3, n4, n5, n6) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5), int(n6)))



def main():
		tblName = 'NYSweetMillion'
		lotto = NYSweetMillion(tblName)
				
		lotto.dbInsert()
		lotto.dbClose()
		lotto.updateXMLFile(tblName)
		lotto.driver.close()
		lotto.driver.quit()

if __name__ == '__main__':
	main()

	
