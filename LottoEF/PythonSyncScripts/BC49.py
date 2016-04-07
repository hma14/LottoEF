
import re #RegEx library
#from urllib import urlopen
from Lottotry import Lottotry
from selenium.webdriver.common.by import By

class BC49(Lottotry):
	
	def __init__(self, tbl):
		super(BC49, self).__init__(tbl)
		driver = self.driver
		driver.get("http://lotto.bclc.com/winning-numbers/bc49-and-extra.html")
				

	def searchDrawDate(self):

		driver = self.driver
		dat = driver.find_elements(By.CLASS_NAME, "date")	
		arr = dat[0].text.split()
		da = arr[2] + '-' + self.dicDateShort2[arr[0]] + '-' + arr[1][:-1]
				
		return da
		


	def searchDrawNumbers(self):
		a = []
		driver = self.driver
		lis = driver.find_elements(By.XPATH, "//ul[@class='list-items']/li")
		for li in lis:
			a.append(li.text)
		numbers = a[0].split()
		a[1] = re.sub(r'Bonus', '', a[1])
		a[1] = a[1].lstrip()
		numbers.append(a[1])
		print numbers
		return numbers
	
	
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
	tblName = 'BC49'
	lotto = BC49(tblName)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.driver.close()
	lotto.driver.quit()
		
if __name__ == '__main__':
	main()
