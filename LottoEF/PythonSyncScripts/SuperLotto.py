
import re #RegEx library
#from urllib import urlopen
from Lottotry import Lottotry
from selenium.webdriver.common.by import By


class SuperLotto(Lottotry):
	
	def __init__(self, tbl, tbl2):
		super(SuperLotto, self).__init__(tbl)
		self.dbTable2 = tbl2
				
		driver = self.driver
		driver.get("http://www.lottery.gov.cn/lottery/dlt/Detail.aspx")

		
		
	def searchDrawNumbers(self):

		numbers = []	
		driver = self.driver
		for i in range(5):
			lst = driver.find_elements(By.ID, "LabelDrawContent_R_%d" % (i+1))
			numbers.append(lst[0].text)
		for i in range(2):
			lst = driver.find_elements(By.ID, "LabelDrawContent_B_%d" % (i+1))
			numbers.append(lst[0].text)
		print numbers
		return numbers
		

	def searchDrawDate(self):
		
		driver = self.driver
		dat = driver.find_element(By.ID, "LabelEventDrawDate")
		match = re.search(r'(\d{4})(\D+)(\d{2})(\D+)(\d{2})', dat.text) 		
		da = match.group(1) + '-' + match.group(3) + '-' + match.group(5)
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
		(n1, n2, n3, n4, n5, b1, b2) = self.searchDrawNumbers()
		self.cursor.execute("insert into " + self.dbTable + " VALUES(%d, '%s', %d, %d, %d, %d, %d)" % 
							(int(dn), ddate, int(n1), int(n2), int(n3), int(n4), int(n5)))
		
		self.cursor.execute("insert into " + self.dbTable2 + " VALUES(%d, '%s', %d, %d)" % 
							(int(dn), ddate, int(b1), int(b2)))


def main():
	tblName = 'SuperLotto'
	tblName2 = 'SuperLotto_Rear'
	lotto = SuperLotto(tblName, tblName2)
		
	lotto.dbInsert()
	lotto.dbClose()
	lotto.updateXMLFile(tblName)
	lotto.updateXMLFile(tblName2)
	lotto.driver.close()
	lotto.driver.quit()

if __name__ == '__main__':
	main()

	
