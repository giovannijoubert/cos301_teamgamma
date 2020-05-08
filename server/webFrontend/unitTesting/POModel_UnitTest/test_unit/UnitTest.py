import unittest
from POModel_UnitTest.pages.Login import Login
from POModel_UnitTest.pages.HomePage import HomePage
from selenium import webdriver
import time
import HtmlTestRunner
import sys
import os
from selenium.webdriver.common.by import By


sys.path.append(os.path.join(os.path.dirname(__file__), "..", ".."))


class UnitTest(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        path = "..\\test_unit\\chromedriver_win32\\chromedriver.exe"
        cls.driver = webdriver.Chrome(path)
        cls.driver.maximize_window()
        cls.driver.get("https://teamgamma.ga/webfrontend/html/Register")
        cls.login = Login(cls.driver)

    def test_01_empty_field_registration(self):
        self.login.register_emptyField()
        time.sleep(2)

    def test_02_empty_username_registration(self):
        self.login.register_emptyUsererName()
        time.sleep(2)

    def test_03_empty_email_registration(self):
        self.login.register_emptyEmail()
        time.sleep(2)

    def test_04_invalid_email_registration(self):
        self.login.register_wrongEmail()
        time.sleep(2)

    def test_05_invalid_password_format_registration(self):
        self.login.register_wrongPassword()
        time.sleep(2)

    def test_06_invalid_login(self):
        self.login.register()
        time.sleep(3)
        self.login.loginpage()

    def test_07_invalid_login(self):
        #Testing invalid login
        self.login.enter_invalid_email()
        time.sleep(2)
        self.login.enter_invalid_password()
        time.sleep(2)
        self.login.click()
        time.sleep(2)

    def test_08_not_registered_login(self):
        # Testing begin here begin here , by first putting the user name and the password of the user
        self.login.enter_non_registered_email()
        time.sleep(2)
        self.login.enter_password()
        time.sleep(2)
        self.login.click()
        time.sleep(2)

    def test_09_login(self):
        # Testing begin here begin here , by first putting the user name and the password of the user
        self.login.enter_email()
        time.sleep(2)
        self.login.enter_password()
        time.sleep(2)
        self.login.click()
        time.sleep(2)

    def test_10_search(self):
        #We are Now doing testing on the homepage
       homepage = HomePage(self.driver)
       homepage.homepage_tst_seach_bar()

    def test_11_links(self):
       homepage = HomePage(self.driver)
       homepage.home_page_link()

    def test_12_buttons(self):
       homepage = HomePage(self.driver)
       homepage.home_page_buttons()

    def test_13_download(self):
       homepage = HomePage(self.driver)
       homepage.home_page_download()

    def test_14_back(self):
        homepage = HomePage(self.driver)
        homepage.home_page_back()

    def test_15_remove(self):
        homepage = HomePage(self.driver)
        homepage.home_page_remove()

    def test_16_monster(self):
        homepage = HomePage(self.driver)
        homepage.home_page_monster()

    def test_17_funny(self):
        homepage = HomePage(self.driver)
        homepage.home_page_funny()

    def test_18_random(self):
        homepage = HomePage(self.driver)
        homepage.home_page_random()

    def test_19_robots(self):
        homepage = HomePage(self.driver)
        homepage.home_page_robots()

    def test_20_animals(self):
        homepage = HomePage(self.driver)
        homepage.home_page_animals()

    def test_21_all(self):
        homepage = HomePage(self.driver)
        homepage.home_page_all()

    def test_22_newest(self):
        homepage = HomePage(self.driver)
        homepage.home_page_newest()

    def test_23_oldest(self):
        homepage = HomePage(self.driver)
        homepage.home_page_oldest()

    def test_24_top(self):
        homepage = HomePage(self.driver)
        homepage.home_page_top()

    def test_25_low(self):
        homepage = HomePage(self.driver)
        homepage.home_page_low()


    @classmethod
    def tearDownClass(cls):
        cls.driver.close()
        cls.driver.quit()


if __name__ == "__main__":
    unittest.main()
